// =====================================================================
// Isorhythm — Color and Talea in SuperCollider
// =====================================================================
// Music and AI — Week 1
//
// Isorhythm (c. 1250-1450): A technique where a repeating rhythmic
// pattern (talea) is combined with a repeating pitch pattern (color)
// of a different length. The two cycle independently, creating
// musical variation until they realign.
//
// Example: If color has 5 notes and talea has 4 durations,
// the pattern repeats every 20 notes (LCM of 5 and 4).
//
// Historical context: Philippe de Vitry and Guillaume de Machaut
// used isorhythm extensively in 14th-century motets. The tenor voice
// would carry a cantus firmus with fixed color and talea, while
// upper voices moved more freely.
// =====================================================================

(
// --- Basic Isorhythm ---
// Color: repeating pitch sequence (scale degrees)
// Talea: repeating rhythm sequence (durations in beats)

var color = [0, 2, 4, 5, 7, 9, 11];   // 7 pitches (C major scale degrees)
var talea = [0.5, 0.25, 0.25, 0.75, 0.25];  // 5 durations

// LCM determines when patterns realign
"Color length: %, Talea length: %, Full cycle: % notes".format(
	color.size, talea.size, lcm(color.size, talea.size)
).postln;

// Simple isorhythm using Pseq with inf repeats
// The key insight: Pseq(color, inf) and Pseq(talea, inf) cycle
// independently because they have different lengths.
// After 35 notes (LCM of 7 and 5), the same pitch-rhythm
// combination recurs for the first time.
Pdef(\isorhythm,
	Pbind(
		\instrument, \default,
		\degree, Pseq(color, inf),
		\dur, Pseq(talea, inf),
		\octave, 5,
		\amp, 0.5,
		\legato, 0.8,
	)
).play;
)

// Stop before trying the next example
Pdef(\isorhythm).stop;


// --- Two-Voice Isorhythm ---
// Medieval motet style: tenor (slow color/talea) + upper voice
// The tenor carries a cantus firmus in long notes while the
// upper voice (duplum) has its own faster isorhythmic pattern.
(
// Tenor: 5-note color with 4-duration talea → cycle of 20 notes
Pdef(\isoTenor,
	Pbind(
		\instrument, \default,
		\degree, Pseq([0, 4, 2, 5, 7], inf),      // 5-note color
		\dur, Pseq([2, 1.5, 1, 2.5], inf),          // 4-duration talea
		\octave, 3,
		\amp, 0.4,
		\legato, 1.0,
	)
).play;

// Upper voice: 6-note color with 5-duration talea → cycle of 30 notes
Pdef(\isoUpper,
	Pbind(
		\instrument, \default,
		\degree, Pseq([7, 5, 4, 2, 4, 5], inf),    // 6-note color
		\dur, Pseq([0.5, 0.25, 0.25, 0.5, 0.5], inf), // 5-duration talea
		\octave, 5,
		\amp, 0.3,
		\legato, 0.6,
	)
).play;
)

// Stop before trying the next example
Pdef(\isoTenor).stop; Pdef(\isoUpper).stop;


// --- Three-Voice Isorhythm with Scale ---
// Adding a middle voice and using a modal scale
(
TempoClock.default.tempo = 100/60;

// Use Dorian mode for a medieval flavor
Pdef(\triTenor,
	Pbind(
		\instrument, \default,
		\scale, Scale.dorian,
		\degree, Pseq([0, 3, 1, 4], inf),           // 4-note color
		\dur, Pseq([3, 2, 2.5], inf),                // 3-duration talea (LCM=12)
		\octave, 3,
		\amp, 0.45,
		\legato, 1.0,
	)
).play;

Pdef(\triMiddle,
	Pbind(
		\instrument, \default,
		\scale, Scale.dorian,
		\degree, Pseq([2, 4, 6, 4, 2], inf),        // 5-note color
		\dur, Pseq([1, 0.5, 0.75, 0.75], inf),      // 4-duration talea (LCM=20)
		\octave, 4,
		\amp, 0.3,
		\legato, 0.7,
	)
).play;

Pdef(\triUpper,
	Pbind(
		\instrument, \default,
		\scale, Scale.dorian,
		\degree, Pseq([7, 6, 5, 4, 3, 2, 3], inf),  // 7-note color
		\dur, Pseq([0.5, 0.25, 0.25, 0.5, 0.25, 0.25], inf), // 6-dur talea (LCM=42)
		\octave, 5,
		\amp, 0.2,
		\legato, 0.5,
	)
).play;
)


// --- Experiment: Changing Parameters ---
// Try modifying:
//
// 1. Different color/talea lengths:
//    Coprime numbers (e.g., 7 and 5) create the longest cycles
//    before the pattern repeats. Try lengths that share a common
//    factor (e.g., 6 and 4) — how does this change the feel?
//
// 2. Different scales:
//    Pdef(\isorhythm).set(\scale, Scale.phrygian)
//    Pdef(\isorhythm).set(\scale, Scale.minor)
//    Pdef(\isorhythm).set(\scale, Scale.chromatic)
//
// 3. Add a third or fourth voice with its own color/talea
//
// 4. Vary dynamics with an isorhythmic amplitude pattern:
//    \amp, Pseq([0.6, 0.3, 0.4, 0.5, 0.3, 0.6, 0.2], inf)
//
// 5. Change the root pitch over time using Pbindf:
//    Pdef(\root, Pbind(\type, \set, \args, [\ctranspose],
//        \ctranspose, Pseq([0, 0, 0, 0, 5, 5, 7, 7], inf),
//        \dur, 8))

// Stop all
Pdef.all.do(_.stop);
