// =====================================================================
// Nth-Order Markov Chain Melody Generation
// =====================================================================
// Music and AI — Week 3
//
// A Markov chain generates sequences where each element depends
// only on the previous n elements (the "context" or "state").
//
// Order 0: Random selection from distribution (no memory)
// Order 1: Next note depends on current note
// Order 2: Next note depends on last 2 notes
// Order n: Next note depends on last n notes
//
// Higher order = more faithful to training data, but less novel.
// Too high = just replaying the original. Too low = random noise.
// The sweet spot depends on corpus size and musical goals.

(
// --- Training corpus ---
// Several melodies to train on (MIDI note numbers)

~corpus = (
    // Twinkle Twinkle Little Star
    twinkle: [60,60,67,67,69,69,67, 65,65,64,64,62,62,60,
              67,67,65,65,64,64,62, 67,67,65,65,64,64,62,
              60,60,67,67,69,69,67, 65,65,64,64,62,62,60],

    // Ode to Joy
    odeToJoy: [64,64,65,67,67,65,64,62,60,60,62,64,64,62,62,
               64,64,65,67,67,65,64,62,60,60,62,64,62,60,60],

    // Frere Jacques
    frere: [60,62,64,60,60,62,64,60,64,65,67,64,65,67,
            67,69,67,65,64,60,67,69,67,65,64,60,60,55,60,60,55,60],
);

// --- Build an nth-order Markov model ---
~buildMarkov = { |melody, order = 1|
    var model = Dictionary.new;
    (melody.size - order).do { |i|
        var context = melody[i..(i + order - 1)];
        var next = melody[i + order];
        var key = context.asString;  // Use string key for array lookup
        if(model[key].isNil) {
            model[key] = List.new;
        };
        model[key].add(next);
    };
    model
};

// --- Generate from a Markov model ---
~generateMarkov = { |model, melody, order = 1, length = 32|
    var output = melody[0..(order - 1)].copy;  // Seed with first n notes
    var context, key, choices;
    (length - order).do {
        context = output[(output.size - order)..];
        key = context.asString;
        choices = model[key];
        if(choices.notNil) {
            output = output.add(choices.choose);
        } {
            // Fallback: random note from corpus
            output = output.add(melody.choose);
        };
    };
    output
};

// --- Compare different orders ---
~comparisons = { |corpusName = \twinkle|
    var melody = ~corpus[corpusName];
    "Training on: % (% notes)".format(corpusName, melody.size).postln;
    "".postln;

    (0..5).do { |order|
        var model, generated;
        if(order == 0) {
            // Order 0: uniform random from corpus notes
            generated = Array.fill(32, { melody.choose });
            "Order 0 (random): %".format(generated).postln;
        } {
            model = ~buildMarkov.(melody, order);
            generated = ~generateMarkov.(model, melody, order, 32);
            "Order %: % (% unique contexts)".format(
                order, generated, model.size
            ).postln;
        };
    };
};

~comparisons.(\twinkle);
)

// --- Play and compare ---
(
// Play original
~playMelody = { |notes, tempo = 4, label = ""|
    "Playing: %".format(label).postln;
    Pdef(label.asSymbol,
        Pbind(
            \midinote, Pseq(notes, 1),
            \dur, 0.25,
            \amp, 0.4,
            \legato, 0.8,
        )
    ).play;
};

// Choose corpus and order
~source = ~corpus[\twinkle];
~order = 2;
~model = ~buildMarkov.(~source, ~order);
~generated = ~generateMarkov.(~model, ~source, ~order, 32);

// Play original then generated
fork {
    ~playMelody.(~source, label: "original");
    (~source.size * 0.25 + 1).wait;
    ~playMelody.(~generated, label: "generated");
};
)

// --- Interactive: try different orders ---
(
~order = 1;  // Change this: 0, 1, 2, 3, 4, 5
~model = ~buildMarkov.(~corpus[\twinkle], ~order);
~generated = ~generateMarkov.(~model, ~corpus[\twinkle], ~order, 48);

Pdef(\markov,
    Pbind(
        \midinote, Pseq(~generated, 1),
        \dur, 0.25,
        \amp, 0.4,
    )
).play;
)

// --- Continuous Markov generation ---
// Real-time generation using Prout (pattern routine)
(
~order = 2;
~model = ~buildMarkov.(~corpus[\twinkle], ~order);

Pdef(\liveMarkov,
    Pbind(
        \midinote, Prout({ |ev|
            var context = ~corpus[\twinkle][0..(~order - 1)].copy;
            var key, choices, next;
            loop {
                key = context.asString;
                choices = ~model[key];
                next = if(choices.notNil, { choices.choose }, { ~corpus[\twinkle].choose });
                context = context.drop(1).add(next);
                next.yield;
            };
        }),
        \dur, 0.25,
        \amp, 0.4,
        \legato, 0.8,
    )
).play;
)

// --- Train on combined corpus ---
(
~combined = ~corpus[\twinkle] ++ ~corpus[\odeToJoy] ++ ~corpus[\frere];
~order = 2;
~model = ~buildMarkov.(~combined, ~order);
~generated = ~generateMarkov.(~model, ~combined, ~order, 64);

Pdef(\combinedMarkov,
    Pbind(
        \midinote, Pseq(~generated, 1),
        \dur, 0.25,
        \amp, 0.4,
    )
).play;
)

// --- Experiment ---
// 1. How does order affect the output? Listen to orders 1-5.
// 2. What happens when you train on a very short vs. very long melody?
// 3. Combine multiple melodies — does the model blend styles?
// 4. Add rhythm: build a separate Markov model for durations
// 5. Can you tell the difference between order 3 and the original?

Pdef.all.do(_.stop);
