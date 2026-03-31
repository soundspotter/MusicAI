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

// input NoteSequence, Pachabel's "Canon" melody in D Major
const sequence = {
    ticksPerQuarter: 220,
    totalTime: 4.0,
    timeSignatures: [{time: 0, numerator: 4, denominator: 4}],
    tempos: [{time: 0, qpm: 120}],
    notes: [ // requires integer MIDI pitch representation
	{ pitch: 66, startTime: 0, endTime: 1 },
	{ pitch: 64, startTime: 1, endTime: 2 },
	{ pitch: 62, startTime: 2, endTime: 3 },
	{ pitch: 61, startTime: 3, endTime: 4 },
	{ pitch: 59, startTime: 4, endTime: 5 },
	{ pitch: 57, startTime: 5, endTime: 6 },
	{ pitch: 59, startTime: 6, endTime: 7 },
	{ pitch: 61, startTime: 7, endTime: 8 },
    ]
}

// Pachabel's "Canon" chord progression, in D Major
const chordProgression = ['D', 'A', 'Bm', 'F#m', 'G', 'D', 'G', 'A7' ] // for improv RNN
const STEPS_PER_QTR = 4
const SAMPLE_DURATION = 30
const SAMPLE_TEMPERATURE = 1.2

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
    const inSequence = core.sequences.quantizeNoteSequence(sequence, 4)
    player.start(inSequence)
    populateSonicPItext(to_sonicpi(inSequence))
}

async function sampleMRNN(){
    console.log("sampleMRNN...")
    // see https://magenta.github.io/magenta-js/music/modules/_core_sequences_.html#quantizenotesequence 
    const inSequence = core.sequences.quantizeNoteSequence(sequence, 4)
    console.log(inSequence)    
    const outSequence = await mrnn.continueSequence(
	inSequence,
	STEPS_PER_QTR * SAMPLE_DURATION,
	SAMPLE_TEMPERATURE, chordProgression).then(
	    seq => {
		player.start(seq);
		let output = to_sonicpi(seq);
		console.log("sonicpi=", output);
		populateSonicPItext(output);
	    }
	    
	);
}

async function startProgram(){
    await mrnn.initialize();
    await Tone.start()    
}

startProgram()

