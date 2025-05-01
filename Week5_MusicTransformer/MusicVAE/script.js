// Music and AI, 2023
// Dartmouth College
// CS 89/189 MUS14, Prof. Michael Casey


// Each bundle exports a global object with the name of the bundle, e.g.:
// music_vae - VAE bundle, defined by magenta, e.g.: new music_vae.MusicVAE(checkpoint)
//      core - Magenta core functions, e.g.: core.Player()

checkpoint = 'https://storage.googleapis.com/magentadata/js/checkpoints/music_vae/'
model = 'mel_4bar_med_q2'
const mvae = new music_vae.MusicVAE(checkpoint + model);
const player = new core.Player();

function sampleMVAE() {
    mvae.sample(1).then(
	(samps) => {player.start(samps[0]); console.log(samps[0].notes)}
    ) 
}

async function startProgram() {
    await mvae.initialize()
    await Tone.start()
}

startProgram();


