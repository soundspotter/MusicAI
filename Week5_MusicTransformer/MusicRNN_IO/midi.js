// Music and AI, 2023
// Dartmouth College
// CS 89/189 MUS14, Prof. Michael Casey

let midi;
let activeMidiOutputDevice = null;

const MIDI_EVENT_ON = 0x90;
const MIDI_EVENT_OFF = 0x80;
const MIDI_LATENCY_MS = 20; // jitter protection, in ms

function midiNoteOut(noteNum, vel, start_time, end_time){
    console.log("MIDI Out: ", noteNum, vel, start_time, end_time);
    activeMidiOutputDevice.send([MIDI_EVENT_ON, noteNum, vel],
				window.performance.now() + start_time + MIDI_LATENCY_MS);
    activeMidiOutputDevice.send([MIDI_EVENT_OFF, noteNum, vel],
				window.performance.now() + end_time + MIDI_LATENCY_MS);
}

async function playNoteListMIDI(notes){ // expects quantized NoteList.notes array
    var start_time = 0;
    var end_time = 0;
    for(n of notes){
	start_time = n.quantizedStartStep*100; // ms
	end_time = n.quantizedEndStep*100; // ms
	midiNoteOut(n.pitch, 100, start_time, end_time);
    }
}

async function initializeMIDI() {
    const navigator = window.navigator;
    midi = await navigator.requestMIDIAccess();

    const midiOutputDevices = [];
    midi.outputs.forEach((output) => {
	midiOutputDevices.push(output);
    });
    console.log(midiOutputDevices.length);
    
    if (midiOutputDevices.length>0){
	activeMidiOutputDevice = midiOutputDevices[0];
    }
    else{
	console.log("no MIDI output device found");
    }    
};

initializeMIDI().then(()=>{console.log("MIDI output initialized.");});
