// =====================================================================
// Sampling Strategies for Sequence Generation
// =====================================================================
// Music and AI — Week 3
//
// Given a probability distribution over next notes, HOW we sample
// from it dramatically affects the output character:
//
// Greedy:      Always pick the highest probability note
//              -> Deterministic, repetitive, but "safe"
//
// Temperature: Scale logits before softmax. t<1 = sharper (more
//              deterministic), t>1 = flatter (more random)
//              P'(x) ~ P(x)^(1/t)
//
// Top-k:       Only sample from the k most likely notes
//              -> Prevents very unlikely choices
//
// Nucleus (top-p): Sample from the smallest set whose cumulative
//              probability exceeds p. Adaptive — more options when
//              distribution is flat, fewer when peaked.
//
// These are the SAME strategies used in LLMs (GPT, Claude, etc.)
// for text generation!

(
// --- Build model from corpus ---
~corpus = [60,60,67,67,69,69,67, 65,65,64,64,62,62,60,
           67,67,65,65,64,64,62, 67,67,65,65,64,64,62,
           60,60,67,67,69,69,67, 65,65,64,64,62,62,60];

~buildModel = { |melody, order = 1|
    var model = Dictionary.new;
    (melody.size - order).do { |i|
        var ctx = melody[i..(i + order - 1)].asString;
        var next = melody[i + order];
        model[ctx] = model[ctx] ? List.new;
        model[ctx].add(next);
    };
    model
};

~getProbs = { |model, context|
    var nexts = model[context.asString];
    var counts, total, probs;
    if(nexts.isNil) { ^Dictionary.new };
    counts = Dictionary.new;
    nexts.do { |n| counts[n] = (counts[n] ? 0) + 1 };
    total = nexts.size;
    probs = Dictionary.new;
    counts.keysValuesDo { |n, c| probs[n] = c / total };
    probs
};

~model = ~buildModel.(~corpus, 1);

// --- 1. Greedy sampling ---
~sampleGreedy = { |probs|
    var maxProb = 0, best = nil;
    probs.keysValuesDo { |note, prob|
        if(prob > maxProb) { maxProb = prob; best = note };
    };
    best
};

// --- 2. Temperature sampling ---
~sampleTemp = { |probs, temperature = 1.0|
    var notes = probs.keys.asArray;
    var ps = probs.values.asArray;
    // Apply temperature: P'(x) ~ P(x)^(1/t)
    ps = ps.collect { |p| p.pow(1.0 / temperature) };
    ps = ps.normalizeSum;
    notes.wchoose(ps)
};

// --- 3. Top-k sampling ---
~sampleTopK = { |probs, k = 3|
    var sorted = probs.asSortedArray.reverse;  // Sort by probability descending
    var topK = sorted[0..(k-1).min(sorted.size-1)];
    var notes = topK.collect(_[0]);
    var ps = topK.collect(_[1]).normalizeSum;
    notes.wchoose(ps)
};

// --- 4. Nucleus (top-p) sampling ---
~sampleNucleus = { |probs, p = 0.9|
    var sorted = probs.asSortedArray.reverse;
    var cumul = 0;
    var nucleus = List.new;
    sorted.do { |pair|
        if(cumul < p) {
            nucleus.add(pair);
            cumul = cumul + pair[1];
        };
    };
    if(nucleus.size == 0) { nucleus.add(sorted[0]) };
    var notes = nucleus.collect(_[0]);
    var ps = nucleus.collect(_[1]).normalizeSum;
    notes.wchoose(ps)
};

// --- Generate melodies with each strategy ---
~generate = { |strategy, args, length = 32|
    var output = [~corpus[0]];
    (length - 1).do {
        var ctx = [output.last];
        var probs = ~getProbs.(~model, ctx);
        var next;
        if(probs.size > 0) {
            next = strategy.(probs, *args);
        } {
            next = ~corpus.choose;
        };
        output = output.add(next);
    };
    output
};

"=== Sampling Strategy Comparison ===".postln;
~strategies = [
    [\greedy, ~sampleGreedy, [], "Greedy (deterministic)"],
    [\tempLow, ~sampleTemp, [0.3], "Temperature 0.3 (conservative)"],
    [\tempMid, ~sampleTemp, [1.0], "Temperature 1.0 (standard)"],
    [\tempHigh, ~sampleTemp, [2.0], "Temperature 2.0 (creative)"],
    [\topk3, ~sampleTopK, [3], "Top-k (k=3)"],
    [\nucleus, ~sampleNucleus, [0.9], "Nucleus (p=0.9)"],
];

~melodies = Dictionary.new;
~strategies.do { |s|
    var name = s[0], fn = s[1], args = s[2], label = s[3];
    ~melodies[name] = ~generate.(fn, args);
    "%: %".format(label, ~melodies[name]).postln;
};
)

// --- Play each strategy ---
(
// Play one at a time — change the key to compare
~which = \tempMid;  // Try: \greedy, \tempLow, \tempMid, \tempHigh, \topk3, \nucleus

Pdef(\sampling,
    Pbind(
        \midinote, Pseq(~melodies[~which], 1),
        \dur, 0.25,
        \amp, 0.4,
        \legato, 0.8,
    )
).play;
)

// --- Play all strategies in sequence for comparison ---
(
Pdef(\compare,
    Pseq(~strategies.collect { |s|
        var name = s[0], label = s[3];
        Pseq([
            // Announce
            Pbind(\degree, \rest, \dur, 1),
            // Play melody
            Pbind(
                \midinote, Pseq(~melodies[name], 1),
                \dur, 0.25,
                \amp, 0.4,
            ),
            Pbind(\degree, \rest, \dur, 2),  // Pause between
        ])
    }, 1)
).play;
)

Pdef.all.do(_.stop);
