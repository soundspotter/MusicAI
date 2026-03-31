// =====================================================================
// Multiple Viewpoint Markov Model
// =====================================================================
// Music and AI — Week 3
//
// A single Markov chain over pitch captures melodic patterns but
// ignores rhythm. A chain over duration captures rhythmic patterns
// but ignores melody. A multiple viewpoint model combines them.
//
// Key idea (Conklin & Witten, 1995; Pearce, 2005):
// P(note | context) ~ P_pitch(note | pitch_context) * P_rhythm(dur | rhythm_context)
//
// Each "viewpoint" (pitch, duration, interval, etc.) has its own
// Markov model. Their predictions are combined via the product rule
// (or geometric mean) to generate notes that are plausible in
// ALL viewpoints simultaneously.

(
// --- Training data: melody with durations ---
// Each element is [midinote, duration]
~trainingData = [
    [60, 1], [60, 1], [67, 1], [67, 1], [69, 0.5], [69, 0.5], [67, 2],
    [65, 1], [65, 1], [64, 1], [64, 1], [62, 0.5], [62, 0.5], [60, 2],
    [67, 1], [67, 1], [65, 0.5], [65, 0.5], [64, 1], [64, 1], [62, 2],
    [67, 1], [67, 1], [65, 0.5], [65, 0.5], [64, 1], [64, 1], [62, 2],
    [60, 1], [60, 1], [67, 1], [67, 1], [69, 0.5], [69, 0.5], [67, 2],
    [65, 1], [65, 1], [64, 1], [64, 1], [62, 0.5], [62, 0.5], [60, 2],
];

// --- Extract viewpoints ---
~pitches = ~trainingData.collect(_[0]);
~durations = ~trainingData.collect(_[1]);
~intervals = (1..~pitches.size-1).collect { |i| ~pitches[i] - ~pitches[i-1] };

// --- Build separate Markov models for each viewpoint ---
~buildModel = { |seq, order = 1|
    var model = Dictionary.new;
    (seq.size - order).do { |i|
        var ctx = seq[i..(i + order - 1)].asString;
        var next = seq[i + order];
        model[ctx] = model[ctx] ? List.new;
        model[ctx].add(next);
    };
    // Convert lists to probability distributions
    var probModel = Dictionary.new;
    model.keysValuesDo { |ctx, nexts|
        var counts = Dictionary.new;
        nexts.do { |n| counts[n] = (counts[n] ? 0) + 1 };
        var total = nexts.size;
        var probs = Dictionary.new;
        counts.keysValuesDo { |n, c| probs[n] = c / total };
        probModel[ctx] = probs;
    };
    probModel
};

~pitchModel = ~buildModel.(~pitches, 1);
~durModel = ~buildModel.(~durations, 1);
~intervalModel = ~buildModel.(~intervals, 1);

// --- Multiple viewpoint generation ---
// Combine pitch and interval viewpoints via product rule
~generateMV = { |length = 32|
    var output = List.new;
    var pitchCtx, durCtx, intCtx;
    var pitch, dur, interval;

    // Seed
    pitch = ~pitches[0];
    dur = ~durations[0];
    output.add([pitch, dur]);

    (length - 1).do { |i|
        var pProbs, iProbs, dProbs, combined;
        var candidates, bestPitch, bestDur;

        // Pitch viewpoint
        pitchCtx = [output.last[0]].asString;
        pProbs = ~pitchModel[pitchCtx] ? Dictionary.new;

        // Interval viewpoint
        if(output.size > 1) {
            interval = output.last[0] - output[output.size - 2][0];
            intCtx = [interval].asString;
            iProbs = ~intervalModel[intCtx] ? Dictionary.new;
        } { iProbs = Dictionary.new };

        // Duration viewpoint
        durCtx = [output.last[1]].asString;
        dProbs = ~durModel[durCtx] ? Dictionary.new;

        // Combine pitch viewpoints via product rule
        if(pProbs.size > 0) {
            // Get all candidate pitches
            candidates = pProbs.keys.asArray;
            // If we also have interval predictions, weight by both
            if(iProbs.size > 0) {
                var intPitches = iProbs.keys.collect { |intv| output.last[0] + intv };
                // Boost candidates that appear in both viewpoints
                combined = Dictionary.new;
                candidates.do { |p|
                    var pWeight = pProbs[p];
                    var iWeight = 0.1;  // default small weight
                    intPitches.do { |ip, j|
                        if(ip == p) { iWeight = iProbs[iProbs.keys.asArray[j]] }
                    };
                    combined[p] = pWeight * iWeight;
                };
                // Normalize and sample
                var total = combined.values.sum;
                var r = total.rand;
                var cumul = 0;
                combined.keysValuesDo { |p, w|
                    cumul = cumul + w;
                    if(cumul >= r and: bestPitch.isNil) { bestPitch = p };
                };
                bestPitch = bestPitch ? candidates.choose;
            } {
                bestPitch = candidates.wchoose(pProbs.values.asArray.normalizeSum);
            };
        } {
            bestPitch = ~pitches.choose;  // Fallback
        };

        // Sample duration
        if(dProbs.size > 0) {
            bestDur = dProbs.keys.asArray.wchoose(dProbs.values.asArray.normalizeSum);
        } {
            bestDur = ~durations.choose;
        };

        output.add([bestPitch, bestDur]);
    };
    output
};

// --- Generate and play ---
~mvMelody = ~generateMV.(32);
"Generated melody (multiple viewpoint):".postln;
~mvMelody.do { |note, i| "  %: pitch=%, dur=%".format(i, note[0], note[1]).postln };
)

// Play it
(
Pdef(\multiView,
    Pbind(
        \midinote, Pseq(~mvMelody.collect(_[0]), 1),
        \dur, Pseq(~mvMelody.collect(_[1]), 1) * 0.5,
        \amp, 0.4,
        \legato, 0.8,
    )
).play;
)

Pdef(\multiView).stop;
