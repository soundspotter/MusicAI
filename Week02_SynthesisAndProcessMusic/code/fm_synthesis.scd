// =====================================================================
// FM Synthesis — Frequency Modulation
// =====================================================================
// Music and AI — Week 2
//
// FM synthesis (John Chowning, 1967/1973): A carrier oscillator's
// frequency is modulated by another oscillator (modulator).
// This creates sidebands that produce complex timbres from
// simple sine waves.
//
// Key parameters:
//   Carrier frequency (C) — the fundamental pitch
//   Modulator frequency (M) — controls sideband spacing
//   C:M ratio — harmonic (integer) vs inharmonic (non-integer)
//   Modulation index (I) — controls brightness/number of sidebands
//     I = Δf / M, where Δf is the frequency deviation

// --- Part 1: Basic FM ---
// Hear how modulation index changes timbre
(
{
	var freq = 440;
	var ratio = 1;  // C:M ratio (try 1, 2, 3, 1.41, 3.01)
	var index = MouseX.kr(0, 20);  // Move mouse to change brightness
	var mod = SinOsc.ar(freq * ratio, 0, freq * index);
	var car = SinOsc.ar(freq + mod, 0, 0.3);
	car ! 2
}.play;
)

// --- Part 2: FM Bell ---
// Non-integer C:M ratio creates inharmonic (bell-like) tones
(
SynthDef(\fmBell, { |out = 0, freq = 440, amp = 0.3, gate = 1,
	modRatio = 3.01, modIndex = 5,
	attack = 0.001, decay = 0.5, sustain = 0.2, release = 2|

	var mod = SinOsc.ar(freq * modRatio, 0, freq * modIndex);
	var car = SinOsc.ar(freq + mod);
	var env = EnvGen.kr(Env.adsr(attack, decay, sustain, release), gate, doneAction: 2);
	Out.ar(out, Pan2.ar(car * env * amp, 0));
}).add;
)

// Bell melody
(
Pdef(\bells,
	Pbind(
		\instrument, \fmBell,
		\degree, Pseq([0, 4, 7, 11, 7, 4], inf),
		\dur, Pseq([1, 0.5, 0.5, 1, 0.5, 0.5], inf),
		\modRatio, Pwhite(2.99, 3.02, inf),  // Slight detuning
		\modIndex, Pseq([3, 5, 8, 5], inf),  // Varying brightness
		\release, 3,
		\amp, 0.25,
	)
).play;
)

// --- Part 3: Harmonic FM ---
// Integer ratios create harmonic timbres (organ, brass, strings)
(
SynthDef(\fmOrgan, { |out = 0, freq = 440, amp = 0.3, gate = 1,
	modRatio = 2, modIndex = 3,
	attack = 0.1, decay = 0.1, sustain = 0.8, release = 0.3|

	// Two-operator FM with feedback
	var mod = SinOsc.ar(freq * modRatio, 0, freq * modIndex);
	var car = SinOsc.ar(freq + mod);
	// Add a second harmonic layer
	var mod2 = SinOsc.ar(freq * 4, 0, freq * 1);
	var car2 = SinOsc.ar(freq * 2 + mod2, 0, 0.3);
	var sig = car + car2;
	var env = EnvGen.kr(Env.adsr(attack, decay, sustain, release), gate, doneAction: 2);
	Out.ar(out, Pan2.ar(sig * env * amp, 0));
}).add;
)

// Organ chord progression
(
Pdef(\organ,
	Pbind(
		\instrument, \fmOrgan,
		\degree, Pseq([[0,2,4], [3,5,7], [4,6,8], [0,2,4]], inf),
		\dur, 2,
		\modIndex, Pseg(Pseq([1, 6, 1], inf), 4, \sin),
		\amp, 0.15,
	)
).play;
)

// --- Part 4: Dynamic FM — index modulation ---
// The classic FM trick: modulate the index with an envelope
(
SynthDef(\fmDynamic, { |out = 0, freq = 440, amp = 0.3, gate = 1,
	modRatio = 1, indexLow = 1, indexHigh = 10,
	attack = 0.01, decay = 0.3, sustain = 0.3, release = 0.5|

	var env = EnvGen.kr(Env.adsr(attack, decay, sustain, release), gate, doneAction: 2);
	// Index envelope: high attack → low sustain (brass-like)
	var indexEnv = EnvGen.kr(Env.perc(0.01, decay + release), gate) * indexHigh + indexLow;
	var mod = SinOsc.ar(freq * modRatio, 0, freq * indexEnv);
	var car = SinOsc.ar(freq + mod);
	Out.ar(out, Pan2.ar(car * env * amp, 0));
}).add;
)

// Brass-like stabs
(
Pdef(\fmBrass,
	Pbind(
		\instrument, \fmDynamic,
		\degree, Pseq([0, 0, 3, 5, 7, 7, 5, 3], inf),
		\dur, 0.25,
		\modRatio, 1,
		\indexLow, 1,
		\indexHigh, Pseq([5, 8, 12, 8], inf),
		\amp, 0.3,
	)
).play;
)

// --- Experiment ---
// 1. Try non-integer ratios: 1.41 (metallic), 2.76 (gong), pi (noise-like)
// 2. Modulate the ratio slowly with an LFO for evolving timbre
// 3. Stack 3+ operators for richer tones (like DX7's 6-operator architecture)
// 4. Use Pbrown for random walks through modIndex values

Pdef.all.do(_.stop);
