// Music and AI, 2023
// Dartmouth College
// CS 89/189 MUS14, Prof. Michael Casey

// Each bundle exports a global object with the name of the bundle.
const player = new core.Player();

// MusicRNN pre-trained model checkpoints:
// 'https://storage.googleapis.com/magentadata/js/checkpoints/music_rnn/basic_rnn'
// 'https://storage.googleapis.com/magentadata/js/checkpoints/music_rnn/'

checkpoint = 'https://storage.googleapis.com/magentadata/js/checkpoints/music_rnn/'
model = 'chord_pitches_improv' // input is list of pitches and chords 

const mrnn = new music_rnn.MusicRNN(checkpoint + model)

// Pachabel's "Canon" chord progression, in D Major
const inSequence = {
	ticksPerQuarter: 220,
	totalTime: 4.0,
	timeSignatures: [{time: 0, numerator: 4, denominator: 4}],
	tempos: [{time: 0, qpm: 120}],
	notes: [] // requires integer MIDI pitch representation
    }

let quantizedOutSequence = inSequence;

let chordProgression = ['D', 'A', 'Bm', 'F#m', 'G', 'D', 'G', 'A7' ] // for improv RNN
let steps_per_qtr = 4
let sample_duration = 15
let sample_temperature = 1.1
let tempo_bpm = 120

function getHTMLinput(){
    let inPitches = document.getElementById("inpitches").value.split(" ")
    let inDurations = document.getElementById("indurations").value.split(" ")
    let inChords = document.getElementById("inchords").value.split(" ")
    sample_temperature = Number( document.getElementById("intemp").value );
    sample_duration = Number( document.getElementById("insampdur").value );
    steps_per_qtr = Number( document.getElementById("instepsperqtr").value );
    tempo_bpm = Number( document.getElementById("intempobpm").value );
    console.log( sample_temperature );
    console.log( sample_duration );
    console.log( steps_per_qtr );
    console.log( tempo_bpm );
    
    // Convert lists of text into a magenta QuantizedNoteSequence
    let notes = []    
    let startTime = 0;
    for(let i=0 ; i<inPitches.length ; i++){
	notes.push({
	    pitch: Number(inPitches[i]),
	    startTime: startTime,
	    endTime: startTime+Number(inDurations[i])
	});
	startTime+=Number(inDurations[i]);
    }
    inSequence.notes = notes
    inSequence.tempos[0].qpm = tempo_bpm
    inSequence.totalTime = startTime * 60.0 / inSequence.tempos[0].qpm
    console.log(inSequence)
}

function populateSonicPItext(output){
    let s = 'pitches = [' // output string
    for (let p of output.pitches) { s += p + ', '}
    s += ']';
    document.getElementById("pitches").value = s;		
    s = 'durations = ['
    for (let d of output.durations) { s += d + ', '}
    s += ']'
    document.getElementById("durations").value = s;
}

async function playInputSequence(){
    getHTMLinput();
    const quantizedInSequence = core.sequences.quantizeNoteSequence(inSequence, steps_per_qtr);
    Tone.Transport.bpm.value = tempo_bpm    
    player.start(quantizedInSequence);
    populateSonicPItext(to_sonicpi(quantizedInSequence));
}

async function playOutputSequence(){
    Tone.Transport.bpm.value = tempo_bpm
    playNoteListMIDI(quantizedOutSequence)    
    player.start(quantizedOutSequence);
}

async function sampleMRNN(){
    console.log("sampleMRNN...")
    getHTMLinput();
    // see https://magenta.github.io/magenta-js/music/modules/_core_sequences_.html#quantizenotesequence 
    const quantizedInSequence = core.sequences.quantizeNoteSequence(inSequence, steps_per_qtr)
    await mrnn.continueSequence(
	quantizedInSequence,
	steps_per_qtr * sample_duration,
	sample_temperature, chordProgression).then(
	    (seq) => {
		quantizedOutSequence = seq;
		console.log(seq);
		let output = to_sonicpi(seq);
		console.log(output);
		populateSonicPItext(output);
	    }	    
	);
}



async function startProgram(){
    await mrnn.initialize();
    await Tone.start();
}

startProgram()

