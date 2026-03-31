// =====================================================================
// Steve Reich's Phasing Technique in SuperCollider
// =====================================================================
// Music and AI — Week 2
//
// Steve Reich's "Piano Phase" (1967): Two pianists play the same
// 12-note pattern. One gradually speeds up until they are one note
// ahead, then locks back in tempo. This process repeats, cycling
// through all 12 possible phase relationships.
//
// This is "process music" — Reich described it as
// "Music as a Gradual Process" (1968):
// "I want to be able to hear the process happening throughout
// the sounding music."

(
// The Piano Phase melody (12 notes)
~phrase = [4, 6, 7, 4, 6, 7, 9, 7, 6, 4, 1, 2];  // Scale degrees in E major

// Simple piano-like synth
SynthDef(\pianoPhase, { |out = 0, freq = 440, amp = 0.3, pan = 0|
	var sig = SinOsc.ar(freq) * 0.5 + SinOsc.ar(freq * 2, 0, 0.25) + SinOsc.ar(freq * 4, 0, 0.1);
	var env = EnvGen.kr(Env.perc(0.005, 0.8), doneAction: 2);
	Out.ar(out, Pan2.ar(sig * env * amp, pan));
}).add;
)

// --- Method 1: Gradual tempo offset ---
// Player 2 plays very slightly faster, causing gradual phase shift
(
var baseTempo = 144/60;
TempoClock.default.tempo = baseTempo;

// Player 1: steady tempo
Pdef(\player1,
	Pbind(
		\instrument, \pianoPhase,
		\scale, Scale.major,
		\degree, Pseq(~phrase, inf),
		\dur, 0.5,
		\pan, -0.5,
		\amp, 0.25,
	)
).play;

// Player 2: slightly faster (1.5% faster = one full phase shift in ~67 bars)
Pdef(\player2,
	Pbind(
		\instrument, \pianoPhase,
		\scale, Scale.major,
		\degree, Pseq(~phrase, inf),
		\dur, 0.5 / 1.015,  // Slightly faster
		\pan, 0.5,
		\amp, 0.25,
	)
).play;
)

// --- Method 2: Discrete phase shifts ---
// Jump to specific phase offsets to hear each alignment
(
// Play at a specific phase offset (0-11)
~playPhase = { |offset = 0|
	"Phase offset: % notes".format(offset).postln;

	Pdef(\player1,
		Pbind(
			\instrument, \pianoPhase,
			\scale, Scale.major,
			\degree, Pseq(~phrase, inf),
			\dur, 0.5,
			\pan, -0.5,
			\amp, 0.25,
		)
	).play;

	Pdef(\player2,
		Pbind(
			\instrument, \pianoPhase,
			\scale, Scale.major,
			\degree, Pseq(~phrase.rotate(offset), inf),
			\dur, 0.5,
			\pan, 0.5,
			\amp, 0.25,
		)
	).play;
};

~playPhase.(0);   // Unison
// ~playPhase.(1);  // 1 note ahead
// ~playPhase.(2);  // 2 notes ahead
// ~playPhase.(6);  // Halfway — maximum difference
)

// --- Method 3: Automatic phase walk ---
// Cycles through all 12 phase positions, staying at each for 8 bars
(
TempoClock.default.tempo = 144/60;

Pdef(\player1,
	Pbind(
		\instrument, \pianoPhase,
		\scale, Scale.major,
		\degree, Pseq(~phrase, inf),
		\dur, 0.5,
		\pan, -0.5,
		\amp, 0.25,
	)
).play;

// Player 2 shifts phase every 48 beats (8 bars of 12 notes * 0.5 dur)
Pdef(\player2,
	Pbind(
		\instrument, \pianoPhase,
		\scale, Scale.major,
		\degree, Pseq(
			(0..11).collect { |offset| Pseq(~phrase.rotate(offset), 8) },  // 8 repetitions per phase
		1),
		\dur, 0.5,
		\pan, 0.5,
		\amp, 0.25,
	)
).play;
)

// --- Experiment ---
// 1. Try with different melodies (shorter or longer patterns)
// 2. What happens with a 7-note pattern? (prime number = no sub-patterns)
// 3. Add a third player with a different phase rate
// 4. Use a richer synth (try \moog or \fmBell)
// 5. Apply this to rhythm: two drum patterns with phasing

Pdef.all.do(_.stop);
