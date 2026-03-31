// Music and AI, 2023
// Dartmouth College
// CS 89/189 MUS14, Prof. Michael Casey

// Minimal standalone use of magenta models
// Michael Casey, Dartmouth, USA
// see https://magenta.github.io/magenta-js/music/

// import depencies, @magenta
const music_vae = require('@magenta/music/node/music_vae');
const sonicpi = require('../sonicpi')

checkpoint = 'https://storage.googleapis.com/magentadata/js/checkpoints/music_vae/'
model = 'mel_4bar_med_q2'
const mvae = new music_vae.MusicVAE(checkpoint + model);

function sampleMVAE(){    
    mvae.sample(1).then(seq => {console.log("sonicpi=", sonicpi.to_sonicpi(seq[0]))})
}

async function startProgram() {
    await mvae.initialize(); // returns a promise
}

// await initialize() promise; when resolved, then sample
startProgram().then(sampleMVAE)


