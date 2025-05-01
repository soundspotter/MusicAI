// Music and AI, 2023
// Dartmouth College
// CS 89/189 MUS14, Prof. Michael Casey

let midi;
let activeMidiOutputDevice = null;
let activeMidiInputDevice = null;

const MIDI_EVENT_ON = 0x90;
const MIDI_EVENT_OFF = 0x80;
const MIDI_LATENCY_MS = 20;

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
    const midiOutDropdownContainer = document.getElementById('midi-out-container');
    const midiInDropdownContainer = document.getElementById('midi-in-container');
    try {
	const navigator = window.navigator;
	midi = await navigator.requestMIDIAccess();

	const midiOutDropdown =
              document.getElementById('midi-out')// as HTMLSelectElement;
	const midiInDropdown =
              document.getElementById('midi-in')// as HTMLSelectElement;

	let outputDeviceCount = 0;
	const midiOutputDevices = [];
	midi.outputs.forEach((output) => {
	    console.log(`
          Output midi device [type: '${output.type}']
          id: ${output.id}
          manufacturer: ${output.manufacturer}
          name:${output.name}
          version: ${output.version}`);
	    midiOutputDevices.push(output);

	    const option = document.createElement('option');
	    option.innerText = output.name;
	    midiOutDropdown.appendChild(option);
	    outputDeviceCount++;
	});
	console.log(outputDeviceCount);
	midiOutDropdown.addEventListener('change', () => {
	    activeMidiOutputDevice =
		midiOutputDevices[midiOutDropdown.selectedIndex - 1];
	});

	if (outputDeviceCount === 0) {
	    midiOutDropdownContainer.innerText = 'midi no output devices found.';
	}

	let inputDeviceCount = 0;
	const midiInputDevices = [];
	midi.inputs.forEach((input) => {
	    console.log(`
        Input midi device [type: '${input.type}']
        id: ${input.id}
        manufacturer: ${input.manufacturer}
        name:${input.name}
        version: ${input.version}`);
	    midiInputDevices.push(input);

	    const option = document.createElement('option');
	    option.innerText = input.name;
	    midiInDropdown.appendChild(option);
	    inputDeviceCount++;
	});

	const setActiveMidiInputDevice = (device) => {
	    if (activeMidiInputDevice != null) {
		activeMidiInputDevice.onmidimessage = () => {};
	    }
	    activeMidiInputDevice = device;
	    device.onmidimessage = (event) => {
		const data = event.data;
		const type = data[0] & 0xf0;
		const note = data[1];
		const velocity = data[2];
		if (type === 144) {
		    midiInNoteOn(note, velocity);
		}
	    };
	};
	midiInDropdown.addEventListener('change', () => {
	    setActiveMidiInputDevice(
		midiInputDevices[midiInDropdown.selectedIndex - 1]);
	});
	if (inputDeviceCount === 0) {
	    midiInDropdownContainer.innerText = 'midi no input devices found.';
	}
    } catch (e) {
	if(midiOutDropdownContainer)
	    midiOutDropdownContainer.innerText = 'midi no output devices found';
	midi = null;
    }
}

initializeMIDI();
