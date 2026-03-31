// =====================================================================
// Voice Leading — Smooth Chord Progressions
// =====================================================================
// Music and AI — Week 3
//
// Voice leading: the art of moving individual voices (notes) as
// smoothly as possible between chords. Good voice leading:
//   1. Minimizes the total distance voices move
//   2. Prefers stepwise motion (intervals of 1-2 semitones)
//   3. Avoids parallel perfect intervals (5ths, octaves)
//   4. Keeps common tones between chords
//
// This is a constraint satisfaction problem: find the voicing of
// each chord that satisfies all rules while minimizing motion.

(
// --- Chord definitions (scale degrees) ---
~chords = (
    I:   [0, 2, 4],      // C E G
    ii:  [1, 3, 5],      // D F A
    iii: [2, 4, 6],      // E G B
    IV:  [3, 5, 7],      // F A C
    V:   [4, 6, 8],      // G B D
    vi:  [5, 7, 9],      // A C E
    vii: [6, 8, 10],     // B D F
);

// --- Find closest voicing ---
// Given a target chord and current voicing, find the arrangement
// of target that minimizes total voice movement
~closestVoicing = { |current, target, scale|
    var numVoices = current.size;
    var targetDegrees = target;
    // Generate all inversions/octave placements
    var candidates = List.new;
    var perms;

    // For each voice, find closest target degree
    var best = Array.fill(numVoices, { |i|
        var curr = current[i];
        var distances = targetDegrees.collect { |t|
            // Find closest octave of this degree
            var options = (-2..2).collect { |oct| t + (oct * 7) };
            var closest = options.minBy { |o| (o - curr).abs };
            closest
        };
        distances
    });

    // Greedy assignment: each voice moves to nearest target note
    var assigned = Array.newClear(numVoices);
    var used = Array.fill(targetDegrees.size, false);

    numVoices.do { |v|
        var minDist = 100, bestTarget = 0;
        best[v].do { |opt, t|
            if(used[t].not and: { (opt - current[v]).abs < minDist }) {
                minDist = (opt - current[v]).abs;
                bestTarget = t;
                assigned[v] = opt;
            };
        };
        used[bestTarget] = true;
    };

    assigned
};

// --- Chord progression with voice leading ---
~progression = [\I, \vi, \IV, \V, \I, \IV, \ii, \V];

// Start with root position I chord
~currentVoicing = [0, 2, 4];  // C E G in scale degrees

~voicings = List.new;
~voicings.add(~currentVoicing);

~progression.drop(1).do { |chordName|
    var target = ~chords[chordName];
    ~currentVoicing = ~closestVoicing.(~currentVoicing, target);
    ~voicings.add(~currentVoicing);
    "% → %".format(chordName, ~currentVoicing).postln;
};
)

// Play the voice-led progression
(
TempoClock.default.tempo = 72/60;

Pdef(\voiceLeading,
    Pbind(
        \scale, Scale.major,
        \degree, Pseq(~voicings, 2),
        \dur, 2,
        \octave, 4,
        \amp, 0.3,
        \legato, 0.95,
        \strum, 0.05,  // Slight strum for clarity
    )
).play;
)

// --- Compare: with vs. without voice leading ---
(
// Without voice leading (root position)
~rootPosition = ~progression.collect { |name| ~chords[name] };

Pdef(\noVoiceLeading,
    Pbind(
        \scale, Scale.major,
        \degree, Pseq(~rootPosition, 2),
        \dur, 2,
        \octave, 4,
        \amp, 0.3,
        \legato, 0.95,
        \strum, 0.05,
    )
).play;
)

// Listen to both — the voice-led version should sound smoother

Pdef.all.do(_.stop);
