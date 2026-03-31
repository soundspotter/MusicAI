// =====================================================================
// Claude OSC Bridge — AI-Assisted Live Coding
// =====================================================================
// Music and AI — Week 7
//
// Bidirectional OSC connection between SuperCollider and an AI.
// The AI sends SC code as OSC messages; SC evaluates and responds.
//
// Setup:
//   1. Boot SC server (s.boot) and load SynthDefs
//   2. Evaluate this file
//   3. From Python, send OSC to localhost:57130
//
// Protocol:
//   /claude/eval <code>        — evaluate SC code string
//   /claude/pdef <name> <code> — define/replace a Pdef
//   /claude/tempo <bpm>        — set TempoClock tempo
//   /claude/stop <name>        — stop a Pdef
//   /claude/state              — request system state snapshot
//
// Responses (sent to localhost:57131):
//   /claude/ok <msg>           — success confirmation
//   /claude/error <msg>        — error message
//   /state/pdefs <csv>         — active Pdef names
//   /state/tempo <float>       — current BPM

(
var claudePort = 57130;
var claudeReplyPort = 57131;
var claudeAddr = NetAddr("localhost", claudeReplyPort);

thisProcess.openUDPPort(claudePort);

// --- Receive and evaluate code ---
OSCdef(\claudeEval, { |msg|
    var code = msg[1].asString;
    "[claude] Evaluating: %".format(code.copyRange(0, 80)).postln;
    try {
        code.interpret;
        claudeAddr.sendMsg('/claude/ok', code.copyRange(0, 40));
    } { |err|
        "[claude] Error: %".format(err.errorString).postln;
        claudeAddr.sendMsg('/claude/error', err.errorString);
    };
}, '/claude/eval');

// --- Define/replace a Pdef ---
OSCdef(\claudePdef, { |msg|
    var name = msg[1].asString.asSymbol;
    var code = msg[2].asString;
    "[claude] Pdef(\\%): %".format(name, code.copyRange(0, 60)).postln;
    try {
        var pattern = code.interpret;
        Pdef(name, pattern).play;
        claudeAddr.sendMsg('/claude/ok', "Pdef(\\%) set".format(name));
    } { |err|
        claudeAddr.sendMsg('/claude/error', err.errorString);
    };
}, '/claude/pdef');

// --- Set tempo ---
OSCdef(\claudeTempo, { |msg|
    var bpm = msg[1] ? 120;
    TempoClock.default.tempo = bpm / 60;
    claudeAddr.sendMsg('/claude/ok', "Tempo: % BPM".format(bpm));
}, '/claude/tempo');

// --- Stop a Pdef ---
OSCdef(\claudeStop, { |msg|
    var name = msg[1].asString.asSymbol;
    Pdef(name).stop;
    claudeAddr.sendMsg('/claude/ok', "Stopped \\%".format(name));
}, '/claude/stop');

// --- Send state snapshot ---
~sendState = {
    var pdefs = Pdef.all.keys.asArray.collect(_.asString).sort.join(",");
    var tempo = TempoClock.default.tempo * 60;
    claudeAddr.sendMsg('/state/pdefs', pdefs);
    claudeAddr.sendMsg('/state/tempo', tempo);
    "[claude] State sent".postln;
};

OSCdef(\claudeState, { |msg|
    ~sendState.();
}, '/claude/state');

"Claude OSC bridge active on port %".format(claudePort).postln;
"  /claude/eval <code>        — evaluate SC code".postln;
"  /claude/pdef <name> <code> — define/replace Pdef".postln;
"  /claude/tempo <bpm>        — set tempo".postln;
"  /claude/stop <name>        — stop Pdef".postln;
"  /claude/state              — request state snapshot".postln;
)

// =====================================================================
// Python Client Example
// =====================================================================
// Save as osc_client.py:
//
//   from pythonosc import udp_client
//   client = udp_client.SimpleUDPClient("127.0.0.1", 57130)
//
//   # Play a note
//   client.send_message("/claude/eval",
//       "Synth(\\default, [\\freq, 440, \\amp, 0.3])")
//
//   # Create a bass pattern
//   client.send_message("/claude/pdef",
//       ["bass", "Pbind(\\degree, Pseq([0,3,5,7],inf), \\dur, 0.5, \\octave, 3)"])
//
//   # Change tempo
//   client.send_message("/claude/tempo", 140)
//
//   # Stop a pattern
//   client.send_message("/claude/stop", "bass")
//
//   # Get state
//   client.send_message("/claude/state", "")
