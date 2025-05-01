// Music and AI, 2023
// Dartmouth College
// CS 89/189 MUS14, Prof. Michael Casey

// Minimal standalone use of magenta models
// Michael Casey, Dartmouth, USA
// see https://magenta.github.io/magenta-js/music/
const music_rnn = require('@magenta/music/node/music_rnn')
const core = require('@magenta/music/node/core')
const sonicpi = require('../sonicpi')
const checkpoint = 'https://storage.googleapis.com/magentadata/js/checkpoints/music_rnn/'

// MusicRNN pre-trained models:
// basic_rnn
// chord_pitches_improv
const model = 'chord_pitches_improv'
const mrnn = new music_rnn.MusicRNN(checkpoint+model)

// input NoteSequence
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

const chordProgression = ['D', 'A', 'Bm', 'F#m', 'G', 'D', 'G', 'A7' ] // for improv RNN
const STEPS_PER_QTR = 4
const SAMPLE_DURATION = 30
const SAMPLE_TEMPERATURE = 1.2

const sampleMRNN = async () => {
    console.log("sampleMRNN...")
    const inSequence = core.sequences.quantizeNoteSequence(sequence, STEPS_PER_QTR)
    const outSequence = await mrnn.continueSequence(
	inSequence,
	SAMPLE_DURATION * STEPS_PER_QTR,
	SAMPLE_TEMPERATURE, chordProgression)
    return outSequence
}

const startProgram = async () => {
    try{
	await mrnn.initialize();
	console.log("Magenta: MRNN started")
    } catch (error) {
	console.error(error)
    }
}

startProgram().then(() => {
    sampleMRNN().then(seq => {console.log("sonicpi=", sonicpi.to_sonicpi(seq))})
})



