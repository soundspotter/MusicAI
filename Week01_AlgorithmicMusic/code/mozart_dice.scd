// =====================================================================
// Mozart's Musikalisches Würfelspiel — Musical Dice Game (K.516f)
// =====================================================================
// Music and AI — Week 1
//
// Published posthumously in 1792 by Nikolaus Simrock.
// A 16-bar minuet is composed by rolling dice to select from
// pre-composed measures. Each bar position has 11 possible choices
// (sum of two dice: 2-12), giving 11^16 ≈ 4.6 × 10^16 possible minuets.
//
// This demonstrates combinatorial composition — the earliest form of
// "algorithmic" music, predating computers by 200+ years.
//
// Key insight: Every possible output sounds like a valid Mozart minuet
// because ALL the musical material was composed by Mozart. The algorithm
// only selects and arranges — it does not generate new material.
// =====================================================================

(
// --- Historical minuet table ---
// Each row = one bar position (0-15)
// Each column = dice sum - 2 (index 0-10, for dice sums 2-12)
// Values are melodic fragments represented as scale degrees
//
// In Mozart's original, these were measure numbers referencing a
// catalog of 176 pre-composed measures. Here we use simplified
// 4-note melodic fragments in scale degrees for playback.

var minuetTable = [
	// Bar 0: 11 options (one for each possible dice sum 2-12)
	[[0,2,4,5], [4,2,4,7], [0,0,2,4], [2,4,5,7], [0,1,2,4],
		[4,5,7,9], [0,2,4,2], [7,5,4,2], [0,4,7,4], [2,0,2,4], [4,7,9,7]],
	// Bar 1
	[[5,4,2,0], [7,5,4,2], [9,7,5,4], [4,2,4,5], [2,4,5,7],
		[0,2,0,-1], [5,7,5,4], [4,2,0,2], [7,9,7,5], [5,4,2,4], [2,0,2,5]],
	// Bar 2
	[[4,5,7,9], [2,4,5,4], [0,2,4,5], [7,5,4,2], [5,7,9,7],
		[4,2,0,2], [9,7,5,4], [2,4,7,5], [0,4,2,0], [5,4,7,5], [7,9,11,9]],
	// Bar 3
	[[2,0,-1,0], [4,5,4,2], [0,2,4,7], [5,4,2,0], [7,5,4,5],
		[2,4,2,0], [0,-1,0,2], [4,2,0,-1], [5,7,5,4], [7,9,7,5], [9,7,5,4]],
	// Bar 4
	[[0,4,7,4], [2,0,2,4], [4,7,9,7], [0,2,0,-1], [5,4,2,0],
		[7,5,7,9], [4,2,4,5], [0,-1,0,2], [2,4,5,7], [7,9,11,7], [5,7,5,4]],
	// Bar 5
	[[4,2,0,2], [5,7,5,4], [7,5,4,2], [0,2,4,5], [2,0,-1,0],
		[9,7,5,7], [4,5,4,2], [7,9,7,5], [0,4,2,0], [5,4,5,7], [2,4,7,9]],
	// Bar 6
	[[7,5,4,2], [0,2,4,7], [5,4,2,0], [4,7,5,4], [2,4,5,7],
		[0,-1,0,2], [9,7,5,4], [7,5,7,9], [4,2,4,5], [5,7,9,7], [0,4,7,11]],
	// Bar 7 (half cadence — all options end on scale degree 4 for dominant feel)
	[[4,2,0,4], [7,4,2,4], [0,4,7,4], [5,4,2,4], [2,4,0,4],
		[4,7,4,2], [0,2,4,7], [7,5,4,2], [4,0,4,7], [2,7,4,2], [0,7,4,0]],
	// Bar 8 (second half begins)
	[[0,2,4,5], [7,5,4,2], [4,5,7,9], [2,0,2,4], [5,4,2,0],
		[0,4,7,4], [9,7,5,4], [4,2,0,2], [7,9,7,5], [2,4,5,7], [5,7,9,11]],
	// Bar 9
	[[4,2,0,-1], [5,4,5,7], [0,2,4,5], [7,5,4,2], [2,4,7,5],
		[4,5,4,2], [9,7,9,7], [0,-1,0,2], [5,7,5,4], [7,9,7,5], [4,2,4,7]],
	// Bar 10
	[[0,4,7,9], [2,0,2,4], [5,4,2,0], [4,5,7,5], [7,5,4,2],
		[0,2,0,-1], [9,7,5,7], [4,2,4,5], [2,4,5,7], [5,7,9,7], [7,9,11,9]],
	// Bar 11
	[[4,2,0,2], [0,2,4,5], [7,5,4,2], [5,4,5,7], [2,0,-1,0],
		[4,7,5,4], [0,4,2,0], [9,7,5,4], [5,7,9,7], [7,5,7,9], [2,4,7,5]],
	// Bar 12
	[[0,2,4,7], [5,4,2,0], [4,5,4,2], [2,4,5,7], [7,5,7,9],
		[0,-1,0,2], [4,2,0,4], [9,7,5,4], [5,7,5,4], [7,9,7,5], [2,0,2,4]],
	// Bar 13
	[[5,4,2,0], [0,2,4,5], [7,5,4,2], [4,7,5,4], [2,4,5,7],
		[9,7,9,7], [0,4,7,4], [5,7,5,4], [4,2,0,2], [7,5,4,5], [0,-1,0,2]],
	// Bar 14
	[[4,5,7,5], [2,0,2,4], [0,4,2,0], [5,4,2,4], [7,9,7,5],
		[4,2,4,7], [0,2,0,-1], [9,7,5,4], [2,4,5,7], [5,7,9,7], [7,5,4,2]],
	// Bar 15 (final cadence — all options resolve to scale degree 0)
	[[4,2,0,0], [0,4,2,0], [7,4,0,0], [2,0,4,0], [5,2,0,0],
		[4,0,7,0], [0,7,4,0], [7,0,4,0], [4,2,7,0], [2,4,0,0], [0,2,4,0]],
];

// --- Roll dice and compose ---
// Change the seed to generate a different minuet
var seed = Date.seed;  // Use current time for a unique composition each run
var composition;

thisThread.randSeed = seed;
composition = List.new;

"".postln;
"========================================".postln;
"Mozart's Dice Game".postln;
"Seed: %".format(seed).postln;
"========================================".postln;
"Rolling dice for 16 bars...".postln;

16.do { |bar|
	// Roll two six-sided dice (sum ranges from 2 to 12)
	var die1 = rrand(1, 6);
	var die2 = rrand(1, 6);
	var diceSum = die1 + die2;
	var tableIndex = diceSum - 2;  // Map sum 2-12 to index 0-10
	"  Bar %: dice = % + % = %, selecting option %".format(
		bar + 1, die1, die2, diceSum, tableIndex
	).postln;
	composition.add(minuetTable[bar][tableIndex]);
};

"".postln;
"Playing minuet (with first-half repeat)...".postln;
"Form: |: bars 1-8 :| bars 9-16".postln;

// --- Play the composed minuet ---
// Classical minuet form: first half repeated, then second half
Pdef(\mozartDice,
	Pbind(
		\instrument, \default,
		\degree, Pseq(
			composition[0..7].flatten    // First half
			++ composition[0..7].flatten // Repeat of first half
			++ composition[8..15].flatten // Second half
		, 1),
		\dur, 0.5,          // Each note = eighth note at minuet tempo
		\octave, 5,
		\scale, Scale.major,
		\amp, 0.4,
		\legato, 0.8,
	)
).play(TempoClock(120/60));  // Minuet tempo
)


// --- Two-voice version ---
// Add a simple bass line that follows the harmonic implications
(
var seed = 99;  // Try different seeds
var minuetTable, composition, bassLine;

thisThread.randSeed = seed;

minuetTable = [
	[[0,2,4,5], [4,2,4,7], [0,0,2,4], [2,4,5,7], [0,1,2,4],
		[4,5,7,9], [0,2,4,2], [7,5,4,2], [0,4,7,4], [2,0,2,4], [4,7,9,7]],
	[[5,4,2,0], [7,5,4,2], [9,7,5,4], [4,2,4,5], [2,4,5,7],
		[0,2,0,-1], [5,7,5,4], [4,2,0,2], [7,9,7,5], [5,4,2,4], [2,0,2,5]],
	[[4,5,7,9], [2,4,5,4], [0,2,4,5], [7,5,4,2], [5,7,9,7],
		[4,2,0,2], [9,7,5,4], [2,4,7,5], [0,4,2,0], [5,4,7,5], [7,9,11,9]],
	[[2,0,-1,0], [4,5,4,2], [0,2,4,7], [5,4,2,0], [7,5,4,5],
		[2,4,2,0], [0,-1,0,2], [4,2,0,-1], [5,7,5,4], [7,9,7,5], [9,7,5,4]],
	[[0,4,7,4], [2,0,2,4], [4,7,9,7], [0,2,0,-1], [5,4,2,0],
		[7,5,7,9], [4,2,4,5], [0,-1,0,2], [2,4,5,7], [7,9,11,7], [5,7,5,4]],
	[[4,2,0,2], [5,7,5,4], [7,5,4,2], [0,2,4,5], [2,0,-1,0],
		[9,7,5,7], [4,5,4,2], [7,9,7,5], [0,4,2,0], [5,4,5,7], [2,4,7,9]],
	[[7,5,4,2], [0,2,4,7], [5,4,2,0], [4,7,5,4], [2,4,5,7],
		[0,-1,0,2], [9,7,5,4], [7,5,7,9], [4,2,4,5], [5,7,9,7], [0,4,7,11]],
	[[4,2,0,4], [7,4,2,4], [0,4,7,4], [5,4,2,4], [2,4,0,4],
		[4,7,4,2], [0,2,4,7], [7,5,4,2], [4,0,4,7], [2,7,4,2], [0,7,4,0]],
	[[0,2,4,5], [7,5,4,2], [4,5,7,9], [2,0,2,4], [5,4,2,0],
		[0,4,7,4], [9,7,5,4], [4,2,0,2], [7,9,7,5], [2,4,5,7], [5,7,9,11]],
	[[4,2,0,-1], [5,4,5,7], [0,2,4,5], [7,5,4,2], [2,4,7,5],
		[4,5,4,2], [9,7,9,7], [0,-1,0,2], [5,7,5,4], [7,9,7,5], [4,2,4,7]],
	[[0,4,7,9], [2,0,2,4], [5,4,2,0], [4,5,7,5], [7,5,4,2],
		[0,2,0,-1], [9,7,5,7], [4,2,4,5], [2,4,5,7], [5,7,9,7], [7,9,11,9]],
	[[4,2,0,2], [0,2,4,5], [7,5,4,2], [5,4,5,7], [2,0,-1,0],
		[4,7,5,4], [0,4,2,0], [9,7,5,4], [5,7,9,7], [7,5,7,9], [2,4,7,5]],
	[[0,2,4,7], [5,4,2,0], [4,5,4,2], [2,4,5,7], [7,5,7,9],
		[0,-1,0,2], [4,2,0,4], [9,7,5,4], [5,7,5,4], [7,9,7,5], [2,0,2,4]],
	[[5,4,2,0], [0,2,4,5], [7,5,4,2], [4,7,5,4], [2,4,5,7],
		[9,7,9,7], [0,4,7,4], [5,7,5,4], [4,2,0,2], [7,5,4,5], [0,-1,0,2]],
	[[4,5,7,5], [2,0,2,4], [0,4,2,0], [5,4,2,4], [7,9,7,5],
		[4,2,4,7], [0,2,0,-1], [9,7,5,4], [2,4,5,7], [5,7,9,7], [7,5,4,2]],
	[[4,2,0,0], [0,4,2,0], [7,4,0,0], [2,0,4,0], [5,2,0,0],
		[4,0,7,0], [0,7,4,0], [7,0,4,0], [4,2,7,0], [2,4,0,0], [0,2,4,0]],
];

composition = List.new;
16.do { |bar|
	var diceSum = rrand(1, 6) + rrand(1, 6);
	composition.add(minuetTable[bar][diceSum - 2]);
};

// Simple bass: take the first note of each measure, hold for the bar
bassLine = composition.collect { |measure| measure[0] };

"Two-voice Mozart dice minuet (seed %)".format(seed).postln;

// Melody
Pdef(\mozartMelody,
	Pbind(
		\degree, Pseq(
			composition[0..7].flatten
			++ composition[0..7].flatten
			++ composition[8..15].flatten
		, 1),
		\dur, 0.5,
		\octave, 5,
		\scale, Scale.major,
		\amp, 0.35,
		\legato, 0.8,
	)
).play(TempoClock(120/60));

// Bass (whole notes, one per bar)
Pdef(\mozartBass,
	Pbind(
		\degree, Pseq(
			bassLine[0..7]
			++ bassLine[0..7]
			++ bassLine[8..15]
		, 1),
		\dur, 2,           // One note per bar (4 eighth notes = 2 beats)
		\octave, 3,
		\scale, Scale.major,
		\amp, 0.3,
		\legato, 1.0,
	)
).play(TempoClock(120/60));
)


// --- Thinking about the numbers ---
//
// 16 bars, each with 11 options = 11^16 possible minuets
// 11^16 = 45,949,729,863,572,161 ≈ 4.6 × 10^16
//
// If you generated one minuet per second, it would take
// about 1.5 billion years to hear them all.
//
// Yet every single one sounds like a plausible Mozart minuet.
// This is because the "creativity" is in the pre-composed fragments
// and the constraints on how they connect (harmonic structure,
// cadence points), not in the selection algorithm.
//
// Questions to consider:
// - Is this "algorithmic composition" or "algorithmic arrangement"?
// - How is this different from (or similar to) a modern AI model
//   trained on Mozart's music?

// Stop all
Pdef(\mozartMelody).stop; Pdef(\mozartBass).stop; Pdef(\mozartDice).stop;
