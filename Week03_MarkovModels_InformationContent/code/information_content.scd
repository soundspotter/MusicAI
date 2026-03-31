// =====================================================================
// Information Content — Measuring Musical Surprise
// =====================================================================
// Music and AI — Week 3
//
// Information Content (Shannon, 1948; Pearce IDyOM, 2005):
//   IC(x) = -log2( P(x | context) )
//
// High IC = surprising/unexpected event (low probability)
// Low IC = predictable/expected event (high probability)
//
// A note that follows common patterns has low IC.
// A note that breaks expectations has high IC.
// Musical interest often correlates with moderate IC —
// too predictable is boring, too surprising is chaotic.
//
// Mean IC (entropy) of a sequence measures overall predictability.

(
// --- Build probability model ---
~buildProbModel = { |melody, order = 1|
    var model = Dictionary.new;
    (melody.size - order).do { |i|
        var ctx = melody[i..(i + order - 1)].asString;
        var next = melody[i + order];
        model[ctx] = model[ctx] ? List.new;
        model[ctx].add(next);
    };
    // Convert to probability distributions
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

// --- Compute IC for each note in a melody ---
~computeIC = { |melody, model, order = 1|
    var icValues = List.new;
    // First 'order' notes have no context — assign IC = 0
    order.do { icValues.add(0) };
    (order..(melody.size - 1)).do { |i|
        var ctx = melody[(i - order)..(i - 1)].asString;
        var note = melody[i];
        var probs = model[ctx];
        var ic;
        if(probs.notNil and: { probs[note].notNil }) {
            ic = log2(probs[note]).neg;  // IC = -log2(P)
        } {
            ic = 8;  // Max surprise for unseen events
        };
        icValues.add(ic);
    };
    icValues.asArray
};

// --- Training data ---
~melody = [60,60,67,67,69,69,67, 65,65,64,64,62,62,60,
           67,67,65,65,64,64,62, 67,67,65,65,64,64,62,
           60,60,67,67,69,69,67, 65,65,64,64,62,62,60];

// Build model and compute IC
~model = ~buildProbModel.(~melody, 1);
~ic = ~computeIC.(~melody, ~model, 1);

// --- Display results ---
"=== Information Content Analysis ===".postln;
"Note\tIC (bits)".postln;
~melody.size.do { |i|
    var noteName = ~melody[i] % 12;
    var names = ["C","C#","D","Eb","E","F","F#","G","Ab","A","Bb","B"];
    "%\t%".format(names[noteName], ~ic[i].round(0.01)).postln;
};

"".postln;
"Mean IC (entropy): % bits".format(~ic.mean.round(0.01)).postln;
"Max IC: % bits (most surprising note)".format(~ic.maxItem.round(0.01)).postln;
"Min IC: % bits (most predictable note)".format(~ic.reject(_ == 0).minItem.round(0.01)).postln;

// Find most surprising moments
"".postln;
"Most surprising notes:".postln;
~ic.do { |val, i|
    if(val > 2) {
        var names = ["C","C#","D","Eb","E","F","F#","G","Ab","A","Bb","B"];
        "  Position %: % (IC = % bits)".format(i, names[~melody[i] % 12], val.round(0.01)).postln;
    };
};
)

// --- Visualize IC as amplitude ---
// Play melody with amplitude proportional to IC
// (surprising notes are louder)
(
Pdef(\icMelody,
    Pbind(
        \midinote, Pseq(~melody, 1),
        \dur, 0.4,
        \amp, Pseq(~ic.normalize(0.1, 0.8), 1),  // Scale IC to amplitude
        \legato, 0.8,
    )
).play;
)

// --- Compare original vs. generated IC ---
(
~order = 2;
~model2 = ~buildProbModel.(~melody, ~order);

// Generate a new melody
~generated = [~melody[0], ~melody[1]];  // Seed
30.do {
    var ctx = ~generated[(~generated.size - ~order)..].asString;
    var probs = ~model2[ctx];
    if(probs.notNil) {
        var notes = probs.keys.asArray;
        var weights = probs.values.asArray;
        ~generated = ~generated.add(notes.wchoose(weights.normalizeSum));
    } {
        ~generated = ~generated.add(~melody.choose);
    };
};

~icOriginal = ~computeIC.(~melody, ~model2, ~order);
~icGenerated = ~computeIC.(~generated, ~model2, ~order);

"Original  — Mean IC: %, Std: %".format(
    ~icOriginal.mean.round(0.01), ~icOriginal.stdDev.round(0.01)).postln;
"Generated — Mean IC: %, Std: %".format(
    ~icGenerated.mean.round(0.01), ~icGenerated.stdDev.round(0.01)).postln;
)

// --- Experiment ---
// 1. How does Markov order affect mean IC?
//    (Higher order -> lower IC for training data)
// 2. Compare IC of original vs. generated melodies
// 3. Do you prefer melodies with moderate IC? Test with listeners.
// 4. Train on one piece, compute IC for a different piece
//    (cross-entropy — measures style similarity)

Pdef.all.do(_.stop);
