// =====================================================================
// Constrained Composition & Voice Leading
// =====================================================================
// Music and AI — Week 3
//
// Constrained composition: Generate music that satisfies explicit rules.
// Unlike Markov chains (which learn patterns statistically), constraint-
// based approaches encode musical knowledge directly:
//   - Avoid parallel fifths and octaves
//   - Voices should move by step when possible
//   - Contrary motion is preferred
//   - Dissonances must resolve
//
// This connects to:
//   - Traditional counterpoint rules (Fux, 1725)
//   - Constraint satisfaction problems (CSP) in AI
//   - Backtracking search algorithms
//
// From the course's scwork/system/patterns/counterpoint.scd

(
// --- Euclidean rhythm helper (needed for voice generation) ---
~euclideanDurs = { |k, n, repeats = inf, rotate = 0|
    var onsets, durs;
    onsets = Array.fill(k, { |i| ((i * n / k).floor + rotate) % n });
    onsets = onsets.sort;
    durs = Array.fill(k, { |i|
        var next;
        next = if(i < (k - 1)) { onsets[i + 1] } { onsets[0] + n };
        (next - onsets[i]) / n;
    });
    Pseq(durs, repeats);
};

// --- Constrained voice generator ---
// Generates a single voice with random scale degrees and Euclidean rhythm
~makeVoice = { |scale = nil, octave = 3, n = nil, barLen = 32|
    var allDegrees, genDegrees, patLengths, degrees;
    allDegrees = (0..5) ++ (0..5) ++ [\rest, \rest];
    genDegrees = { |nn| allDegrees.scramble.slice((0..nn-1)) };
    patLengths = [7, 11, 13, 17, 23];  // Prime numbers!
    n = n ? patLengths.choose;
    scale = scale ? Scale.choose;
    degrees = genDegrees.(n);
    Pbind(
        \scale, scale,
        \octave, octave,
        \degree, Pser(degrees, n),
        \dur, ~euclideanDurs.(n, barLen, 1) * 2,
        \amp, 0.3,
    )
};

// --- Multi-voice counterpoint ---
~multiVoice = { |numVoices = 3, scale = nil|
    var octaves = [3, 4, 5, 6];
    scale = scale ? Scale.choose;
    Ppar(
        numVoices.collect { |i|
            ~makeVoice.(scale, octaves.wrapAt(i))
        }
    )
};

// --- Interval constraint checker ---
~intervals = { |chord|
    all {: chord[i + gap] - chord[i],
        gap <- (1..chord.lastIndex),
        i <- (0..chord.lastIndex - gap)
    }
};

// --- Voice leading constraint ---
// Check that voices move by step (interval <= 2 scale degrees)
~goodVoiceLeading = { |prev, curr|
    var motion = (curr - prev).abs;
    motion <= 2  // Step motion preferred
};

// --- Parallel fifths/octaves check ---
~noParallels = { |prevChord, currChord|
    var prevIntervals = ~intervals.(prevChord);
    var currIntervals = ~intervals.(currChord);
    var hasParallel = false;
    prevIntervals.size.do { |i|
        if(prevIntervals[i] == currIntervals[i]) {
            if([7, 12, 0].includes(currIntervals[i] % 12)) {
                hasParallel = true;
            };
        };
    };
    hasParallel.not
};
)

// --- Play unconstrained counterpoint ---
(
TempoClock.default.tempo = 100/60;
Pdef(\counterpoint, ~multiVoice.(3, Scale.dorian)).play;
)

// --- Play with a specific scale and voice count ---
(
Pdef(\counterpoint2, ~multiVoice.(4, Scale.minor)).play;
)

// --- Phrase-based backtracking composition ---
// Pre-composed phrases that are combined via search
(
~phrases = [
    Pbind(\degree, Pseq([0, -2, 1, 2, 1, 6, 4]),
        \dur, Pseq([0.75, 0.25, 0.25, 0.5, 0.25, 0.75, 0.75])),
    Pbind(\degree, Pseq([7, 4, 3, 1, -2, 0, 1]),
        \dur, Pseq([0.5, 0.75, 0.25, 0.5, 0.25, 0.25, 0.75])),
    Pbind(\degree, Pseq([2, 1, 0, 1, 2, 4, 5, 1]),
        \dur, Pseq([0.25, 0.25, 0.25, 0.25, 0.25, 0.25, 0.25, 0.75])),
    Pbind(\degree, Pseq([4, 5, 4, 5, 7, 8, 7, 9, 6]),
        \dur, Pseq([0.5, 0.5, 0.25, 0.25, 0.25, 0.5, 0.25, 0.75, 0.75])),
];

// Random phrase concatenation
Pdef(\phraseBased,
    Pbind(
        \scale, Scale.dorian,
        \octave, 5,
        \amp, 0.4,
    ) <> Prand(~phrases, 8)  // 8 random phrases
).play;
)

// --- Experiment ---
// 1. Modify ~makeVoice to enforce step-motion constraints
// 2. Add rules: no parallel 5ths, resolve dissonances
// 3. Compare: random generation vs. constrained generation
// 4. Try different scales: Scale.phrygian, Scale.lydian, Scale.whole

Pdef.all.do(_.stop);
