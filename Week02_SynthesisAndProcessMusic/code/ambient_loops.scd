// =====================================================================
// Ambient Loops — Brian Eno's Discreet Music in SuperCollider
// =====================================================================
// Music and AI — Week 2
//
// Brian Eno's approach to ambient music (1975):
// "I wanted to make a piece that could be listened to and yet
// could be ignored... like the color of light."
//
// Key technique: Two melodic loops of different lengths play
// simultaneously. Because they cycle at different rates, they
// continuously create new combinations. With long reverb and
// delay, the notes blur into an evolving ambient wash.
//
// This is "process music" — the composer sets up a system and
// lets it unfold. The music writes itself.

(
// --- Effects bus for shared reverb/delay ---
~reverbBus = Bus.audio(s, 2);

// Reverb effect
SynthDef(\ambientReverb, { |out = 0, inbus, room = 0.95, damp = 0.9, mix = 0.8|
	var sig = In.ar(inbus, 2);
	var rev = FreeVerb2.ar(sig[0], sig[1], mix, room, damp);
	Out.ar(out, rev);
}).add;

// Simple sustained pad synth
SynthDef(\ambientTone, { |out = 0, freq = 440, amp = 0.3, pan = 0, gate = 1,
	attack = 2, release = 8|
	var sig = SinOsc.ar(freq, 0, amp) + SinOsc.ar(freq * 2.01, 0, amp * 0.3);
	var env = EnvGen.kr(Env.asr(attack, 1, release), gate, doneAction: 2);
	Out.ar(out, Pan2.ar(sig * env, pan));
}).add;
)

(
// Start reverb
~reverb = Synth(\ambientReverb, [\inbus, ~reverbBus, \room, 0.95, \damp, 0.9]);

// --- Loop 1: 12 notes ---
// Adapted from Eno's Discreet Music
Pdef(\loop1,
	Pbind(
		\instrument, \ambientTone,
		\out, ~reverbBus,
		\midinote, Pseq([61, 63, \rest, 53, \rest, 56, \rest, 65, 68, 70, 68, \rest], inf),
		\dur, Pseq([1, 3, 4, 4, 4, 4, 4, 1, 1, 1, 2, 3], inf),
		\amp, 0.15,
		\pan, -0.7,
		\attack, 1,
		\release, 8,
	)
).play;

// --- Loop 2: 10 notes ---
// Different length creates phase drift (ratio ≈ 63.5/68.7)
Pdef(\loop2,
	Pbind(
		\instrument, \ambientTone,
		\out, ~reverbBus,
		\midinote, Pseq([63, 65, \rest, 60, 56, \rest, 51, \rest, 56, \rest], inf),
		\dur, Pseq([2, 3, 3, 1, 3, 4, 4, 4, 4, 4], inf) * (63.5/68.7),  // Eno's ratio
		\amp, 0.15,
		\pan, 0.7,
		\attack, 1,
		\release, 8,
	)
).play;
)

// Let this run for several minutes — the two loops
// continuously drift against each other, creating new harmonies.

// --- Music for Airports style ---
// Even simpler: single notes with very long tails, random timing
(
Pdef(\airports,
	Pbind(
		\instrument, \ambientTone,
		\out, ~reverbBus,
		\midinote, Prand([56, 58, 60, 63, 65, 68, 70, 72, 75], inf),
		\dur, Pwhite(3.0, 12.0, inf),
		\amp, Pwhite(0.05, 0.15, inf),
		\pan, Pwhite(-1.0, 1.0, inf),
		\attack, Pwhite(2.0, 5.0, inf),
		\release, Pwhite(8.0, 15.0, inf),
	)
).play;
)

// --- Experiment ---
// 1. Change the loop ratio — try irrational numbers (pi/e ≈ 1.156)
// 2. Add a third loop with yet another length
// 3. Try different scales/modes for different moods
// 4. Add gentle LFO modulation to the synth

// Stop
Pdef.all.do(_.stop);
~reverb.free;
