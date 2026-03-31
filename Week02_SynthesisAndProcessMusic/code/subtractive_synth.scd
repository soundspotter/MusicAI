// =====================================================================
// Subtractive Synthesis in SuperCollider
// =====================================================================
// Music and AI — Week 2
//
// Subtractive synthesis starts with harmonically rich waveforms
// (saw, pulse, noise) and shapes them with filters and envelopes.
// This is the basis of Moog, ARP, and most analog synthesizers.

// --- Part 1: Oscillator Zoo ---
// Listen to each waveform's harmonic content
(
// Sawtooth: all harmonics (1, 2, 3, 4, ...) — bright, buzzy
{ Saw.ar(220, 0.3) }.play;
)
// Pulse/Square: odd harmonics (1, 3, 5, 7, ...) — hollow
(
{ Pulse.ar(220, 0.5, 0.3) }.play;
)
// Sine: fundamental only — pure, clean
(
{ SinOsc.ar(220, 0, 0.3) }.play;
)
// White noise: all frequencies — used for percussion, texture
(
{ WhiteNoise.ar(0.2) }.play;
)

// --- Part 2: Filters ---
// Low-pass filter removes high frequencies (controls brightness)
(
{
	var sig = Saw.ar(220);
	var cutoff = MouseX.kr(100, 10000, 1); // Move mouse left-right
	RLPF.ar(sig, cutoff, 0.3, 0.3)
}.play;
)

// --- Part 3: Envelopes ---
// ADSR shapes amplitude over time
(
SynthDef(\simpleSub, { |out = 0, freq = 440, amp = 0.5, gate = 1,
	cutoff = 2000, resonance = 0.3,
	attack = 0.01, decay = 0.2, sustain = 0.7, release = 0.5|

	var sig = Saw.ar(freq) + Pulse.ar(freq * 1.003, 0.5, 0.5);
	var env = EnvGen.kr(Env.adsr(attack, decay, sustain, release), gate, doneAction: 2);
	var filtered = RLPF.ar(sig, cutoff * env, resonance);
	Out.ar(out, Pan2.ar(filtered * env * amp, 0));
}).add;
)

// Play with Pbind
(
Pdef(\subMelody,
	Pbind(
		\instrument, \simpleSub,
		\degree, Pseq([0, 2, 4, 5, 7, 5, 4, 2], inf),
		\dur, 0.5,
		\cutoff, Pseq([2000, 3000, 4000, 3000], inf),
		\amp, 0.3,
	)
).play;
)

// --- Part 4: The Moog SynthDef ---
// Classic Moog-style: dual oscillators, MoogFF filter, full ADSR
(
SynthDef(\moog, { |out = 0, freq = 440, amp = 0.5, pan = 0, gate = 1,
	oscType = 0, oscType2 = 1,
	cutoff = 2000, gain = 3.3,
	attack = 0.01, decay = 0.2, sustain = 0.7, release = 0.5,
	filterAttack = 0.01, filterDecay = 0.2, filterSustain = 0.9, filterRelease = 0.5|

	var oscArray = [Saw.ar(freq), SinOsc.ar(freq), Pulse.ar(freq)];
	var oscArray2 = [Saw.ar(freq * 1.003), SinOsc.ar(freq * 0.997), Pulse.ar(freq * 1.003)];
	var osc1 = Select.ar(oscType, oscArray);
	var osc2 = Select.ar(oscType2, oscArray2);
	var mix = XFade2.ar(osc1, osc2, pan);
	var ampEnv = EnvGen.kr(Env.adsr(attack, decay, sustain, release), gate, doneAction: 2);
	var filterEnv = EnvGen.kr(Env.adsr(filterAttack, filterDecay, filterSustain, filterRelease), gate);
	var filtered = MoogFF.ar(mix, cutoff * filterEnv, gain);
	Out.ar(out, Pan2.ar(filtered * ampEnv * amp, pan));
}).add;
)

// Moog bass line
(
Pdef(\moogBass,
	Pbind(
		\instrument, \moog,
		\degree, Pseq([0, 0, 3, 5, 7, 5, 3, 0], inf),
		\octave, 3,
		\dur, Pseq([0.5, 0.25, 0.25, 0.5, 0.5, 0.25, 0.25, 0.5], inf),
		\cutoff, Pseg(Pseq([800, 4000, 800], inf), 4, \exp),
		\gain, 3.5,
		\amp, 0.4,
		\release, 0.3,
	)
).play;
)

// --- Experiment ---
// 1. Modify \simpleSub: add a second oscillator slightly detuned
// 2. Try different filter types: MoogFF, BPF, HPF
// 3. Modulate cutoff with an LFO inside the SynthDef
// 4. Create a pad sound with long attack/release

Pdef.all.do(_.stop);
