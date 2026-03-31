// =====================================================================
// Euclidean Rhythms — The Bjorklund Algorithm
// =====================================================================
// Music and AI — Week 1
//
// Euclidean rhythms distribute k onsets as evenly as possible across
// n steps. Remarkably, many traditional world music rhythms are
// Euclidean:
//
//   E(3,8)  = [x . . x . . x .] — Cuban tresillo
//   E(5,8)  = [x . x x . x x .] — Cuban cinquillo
//   E(5,12) = [x . . x . x . . x . x .] — South African bell
//   E(7,12) = [x . x x . x . x x . x .] — West African bell
//   E(4,12) = [x . . x . . x . . x . .] — common 12/8 pulse
//   E(7,16) = [x . x x . x . x . x x . x . x .] — Brazilian samba
//   E(2,5)  = [x . x . .] — khafif-e-ramal (Persian)
//   E(3,4)  = [x . x x] — cumbia (Colombia)
//
// The connection to Euclid: the algorithm for distributing onsets
// evenly is structurally identical to Euclid's algorithm for
// computing the greatest common divisor (GCD). Bjorklund (2003)
// discovered this while working on neutron accelerator timing at
// Los Alamos National Laboratory. Toussaint (2005) connected it
// to world music traditions.
//
// References:
//   Toussaint, "The Euclidean Algorithm Generates Traditional
//   Musical Rhythms" (2005)
//   Bjorklund, "The Theory of Rep-Rate Pattern Generation in the
//   SNS Timing System" (2003)
// =====================================================================

(
// --- Euclidean duration generator ---
// Converts a k-in-n onset pattern to a Pseq of durations.
// No external quark/library dependency — pure SC.
//
// Parameters:
//   k       — number of onsets (hits)
//   n       — number of steps (total grid positions)
//   repeats — how many times to cycle (default: inf)
//   rotate  — rotate the pattern by this many steps (shifts the downbeat)

~euclideanDurs = { |k, n, repeats = inf, rotate = 0|
	var onsets, durs;
	// Calculate onset positions using the Euclidean distribution formula
	onsets = Array.fill(k, { |i| ((i * n / k).floor + rotate) % n });
	onsets = onsets.sort;
	// Convert onset positions to inter-onset durations
	// Each duration = distance to the next onset, normalized so total = 1 beat per step
	durs = Array.fill(k, { |i|
		var next;
		next = if(i < (k - 1)) { onsets[i + 1] } { onsets[0] + n };
		(next - onsets[i]) / n;
	});
	Pseq(durs, repeats);
};


// --- Visualize a Euclidean rhythm ---
// Prints a grid representation: x = onset, . = rest
~showRhythm = { |k, n, label = ""|
	var onsets = Array.fill(k, { |i| ((i * n / k).floor) % n }).sort;
	var grid = Array.fill(n, { |i| if(onsets.includes(i), "x", ".") });
	var name = if(label.size > 0, " — " ++ label, "");
	"E(%,%) = [%]%".format(k, n, grid.join(" "), name).postln;
};


// --- Display famous Euclidean rhythms ---
"".postln;
"=== Famous Euclidean Rhythms ===".postln;
~showRhythm.(2, 5, "khafif-e-ramal (Persian)");
~showRhythm.(3, 4, "cumbia (Colombia)");
~showRhythm.(3, 8, "tresillo (Cuba)");
~showRhythm.(5, 8, "cinquillo (Cuba)");
~showRhythm.(4, 12, "12/8 pulse");
~showRhythm.(5, 12, "South African bell");
~showRhythm.(7, 12, "West African bell");
~showRhythm.(7, 16, "Brazilian samba");
"".postln;
)


// =============================================
// Example 1: Single Euclidean rhythm
// =============================================
(
TempoClock.default.tempo = 120/60;

// E(5,8) — Cuban cinquillo
Pdef(\euclidean,
	Pbind(
		\instrument, \default,
		\dur, ~euclideanDurs.(5, 8),
		\degree, 0,
		\octave, 5,
		\amp, 0.5,
	)
).play;
)

Pdef(\euclidean).stop;


// =============================================
// Example 2: Layered Euclidean polyrhythm
// =============================================
// Different k values over the same n create interlocking patterns.
// This is how many West African drum ensembles work — each
// instrument plays a different Euclidean pattern over a shared cycle.
(
TempoClock.default.tempo = 110/60;

// High: E(7,16) — dense, samba-like pattern
Pdef(\eucHigh,
	Pbind(
		\instrument, \default,
		\dur, ~euclideanDurs.(7, 16),
		\degree, 7,
		\octave, 6,
		\amp, 0.2,
		\legato, 0.3,
	)
).play;

// Mid: E(5,16) — medium density
Pdef(\eucMid,
	Pbind(
		\instrument, \default,
		\dur, ~euclideanDurs.(5, 16),
		\degree, 0,
		\octave, 5,
		\amp, 0.4,
		\legato, 0.5,
	)
).play;

// Low: E(3,16) — sparse bass pulse
Pdef(\eucLow,
	Pbind(
		\instrument, \default,
		\dur, ~euclideanDurs.(3, 16),
		\degree, 0,
		\octave, 3,
		\amp, 0.6,
		\legato, 0.8,
	)
).play;
)

Pdef(\eucHigh).stop; Pdef(\eucMid).stop; Pdef(\eucLow).stop;


// =============================================
// Example 3: Polymetric Euclidean
// =============================================
// Different step counts (n) create polymetric feel.
// E(3,8) against E(4,12) = 3-against-4 polyrhythm.
(
TempoClock.default.tempo = 100/60;

Pdef(\polyA,
	Pbind(
		\instrument, \default,
		\dur, ~euclideanDurs.(3, 8),
		\degree, 0,
		\octave, 4,
		\amp, 0.5,
		\legato, 0.6,
	)
).play;

Pdef(\polyB,
	Pbind(
		\instrument, \default,
		\dur, ~euclideanDurs.(4, 12),
		\degree, 4,
		\octave, 5,
		\amp, 0.3,
		\legato, 0.4,
	)
).play;
)

Pdef(\polyA).stop; Pdef(\polyB).stop;


// =============================================
// Example 4: Rotation changes the groove
// =============================================
// The same E(3,8) pattern sounds very different depending on
// which beat is treated as the downbeat.
(
TempoClock.default.tempo = 120/60;

"E(3,8) with different rotations:".postln;

// Rotation 0: [x . . x . . x .]  — standard tresillo
Pdef(\rot0,
	Pbind(
		\dur, ~euclideanDurs.(3, 8, inf, 0),
		\degree, 0, \octave, 5, \amp, 0.4,
	)
).play;
)

// Now try rotation 1: shifts the pattern start
(
Pdef(\rot0,
	Pbind(
		\dur, ~euclideanDurs.(3, 8, inf, 1),
		\degree, 0, \octave, 5, \amp, 0.4,
	)
).play;
)

// Rotation 2: yet another feel from the same 3 hits in 8
(
Pdef(\rot0,
	Pbind(
		\dur, ~euclideanDurs.(3, 8, inf, 2),
		\degree, 0, \octave, 5, \amp, 0.4,
	)
).play;
)

Pdef(\rot0).stop;


// =============================================
// Example 5: Melodic Euclidean
// =============================================
// Euclidean rhythms are not just for percussion —
// they can drive melodic patterns too.
(
TempoClock.default.tempo = 108/60;

Pdef(\eucMelody,
	Pbind(
		\instrument, \default,
		\scale, Scale.dorian,
		\degree, Pseq([0, 2, 4, 5, 7, 5, 4, 2], inf),
		\dur, ~euclideanDurs.(5, 8),    // Cinquillo rhythm
		\octave, 5,
		\amp, 0.35,
		\legato, 0.7,
	)
).play;

// Bass on a different Euclidean grid
Pdef(\eucBass,
	Pbind(
		\instrument, \default,
		\scale, Scale.dorian,
		\degree, Pseq([0, 0, 3, 3, 4, 4, 0, 0], inf),
		\dur, ~euclideanDurs.(3, 8),    // Tresillo rhythm
		\octave, 3,
		\amp, 0.45,
		\legato, 1.0,
	)
).play;
)

Pdef(\eucMelody).stop; Pdef(\eucBass).stop;


// --- Experiments to try ---
//
// 1. Rotation: ~euclideanDurs.(k, n, inf, rotate)
//    The rotate parameter shifts which step is the "downbeat."
//    Same pattern, completely different groove feel.
//
// 2. Coprime numbers: When GCD(k,n) = 1, the pattern has maximum
//    complexity. Compare E(3,8) vs E(4,8) vs E(3,9).
//
// 3. Layer 4+ Euclidean patterns with different timbres.
//    Use SynthDefs from the system/synthdefs/ folder if available.
//
// 4. Dynamic density: Use Prand to choose between different k values:
//    \dur, Pswitch1([
//        ~euclideanDurs.(3, 16, 1),
//        ~euclideanDurs.(5, 16, 1),
//        ~euclideanDurs.(7, 16, 1),
//    ], Prand([0, 1, 2], inf))
//
// 5. Compare SC's built-in spread() equivalent:
//    Pbjorklund2(k, n) from the Bjorklund quark does the same thing
//    if installed. Our ~euclideanDurs function works without any quarks.

// Stop all
Pdef.all.do(_.stop);
