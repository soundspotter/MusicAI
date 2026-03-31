// =====================================================================
// MIDI & OSC Basics in SuperCollider
// =====================================================================
// Music and AI — Week 3
//
// MIDI (Musical Instrument Digital Interface, 1983):
// - Note On/Off messages: note number (0-127), velocity (0-127)
// - Control Change (CC): controller number, value
// - Channel 0-15
//
// OSC (Open Sound Control):
// - Network protocol for music software communication
// - Hierarchical address space: /synth/freq, /effect/reverb
// - Arbitrary data types (ints, floats, strings)

// --- MIDI Setup ---
(
MIDIClient.init;
MIDIIn.connectAll;
"MIDI initialized".postln;
)

// --- Receiving MIDI Notes ---
(
// Print incoming MIDI notes
MIDIdef.noteOn(\noteDebug, { |vel, note, chan, src|
    "Note ON:  note=%, vel=%, chan=%".format(note, vel, chan).postln;
});

MIDIdef.noteOff(\noteOffDebug, { |vel, note, chan, src|
    "Note OFF: note=%, chan=%".format(note, chan).postln;
});

MIDIdef.cc(\ccDebug, { |val, num, chan, src|
    "CC: num=%, val=%, chan=%".format(num, val, chan).postln;
});
)

// --- MIDI-controlled synth ---
(
SynthDef(\midiSynth, { |out = 0, freq = 440, amp = 0.5, gate = 1|
    var sig = Saw.ar(freq) + Pulse.ar(freq * 1.003);
    var env = EnvGen.kr(Env.adsr(0.01, 0.2, 0.7, 0.3), gate, doneAction: 2);
    var filt = MoogFF.ar(sig, freq * 4, 2);
    Out.ar(out, Pan2.ar(filt * env * amp, 0));
}).add;

~notes = Array.newClear(128);

MIDIdef.noteOn(\synthOn, { |vel, note|
    ~notes[note] = Synth(\midiSynth, [
        \freq, note.midicps,
        \amp, vel / 127 * 0.5
    ]);
});

MIDIdef.noteOff(\synthOff, { |vel, note|
    ~notes[note].set(\gate, 0);
    ~notes[note] = nil;
});
)

// --- Sending MIDI Out ---
(
// Find MIDI output devices
MIDIClient.destinations.do { |ep, i|
    "MIDI Out %: % — %".format(i, ep.device, ep.name).postln;
};
)

// Send notes to an external synth
(
~midiOut = MIDIOut(0);  // First MIDI output
~midiOut.latency = 0;

// Play a scale via MIDI
fork {
    [60, 62, 64, 65, 67, 69, 71, 72].do { |note|
        ~midiOut.noteOn(0, note, 80);
        0.3.wait;
        ~midiOut.noteOff(0, note, 0);
        0.05.wait;
    };
};
)

// --- OSC Communication ---
(
// Receive OSC messages
OSCdef(\oscReceive, { |msg, time, addr|
    "OSC received: % from %".format(msg, addr).postln;
}, '/test');

// Open a port for receiving
thisProcess.openUDPPort(9000);
"Listening for OSC on port 9000".postln;
)

// Send OSC
(
~oscTarget = NetAddr("localhost", 9000);
~oscTarget.sendMsg('/test', 440, 0.5, "hello");
)

// --- Keyboard MIDI to pattern recording ---
// Record MIDI input into a list for Markov chain training
(
~recordedNotes = List.new;
~recording = true;

MIDIdef.noteOn(\recorder, { |vel, note|
    if(~recording, {
        ~recordedNotes.add(note);
        "Recorded note %: %".format(~recordedNotes.size, note).postln;
    });
});

"Recording MIDI input... play some notes, then set ~recording = false".postln;
)

// Stop recording
~recording = false;
"Recorded % notes: %".format(~recordedNotes.size, ~recordedNotes).postln;

// Clean up
MIDIdef.freeAll;
OSCdef.freeAll;
