// Music and AI, 2023
// Dartmouth College
// CS 89/189 MUS14, Prof. Michael Casey


// Each bundle exports a global object with the name of the bundle, e.g.:
//      ddsp - DDSP bundle, defined by magenta, e.g.: new ddsp.ddsp
//      core - Magenta core functions, e.g.: core.Player()

const checkpoint = 'https://storage.googleapis.com/magentadata/js/checkpoints/ddsp/'
const model = 'tenor_saxophone'

const audio_ddsp = new ddsp.DDSP(checkpoint + model);

//async function loadAudioFromFile(blob: Blob): Promise<AudioBuffer> {
//  const fileReader = new FileReader();
//  const loadFile: Promise<ArrayBuffer> = new Promise((resolve, reject) => {
//    fileReader.onerror = () => {
//      fileReader.abort();
//      reject(new DOMException('Something went wrong reading that file.'));
//    };
//    fileReader.onload = () => {
//      resolve(fileReader.result as ArrayBuffer);
//    };
//    fileReader.readAsArrayBuffer(blob);
//  });
//  return loadFile.then(
//      (arrayBuffer) => offlineCtx.decodeAudioData(arrayBuffer));
//}

async function upload(){
    let audio_file = document.getElementById("input").files[0]
    let audio_inbuf = await e.loadAudioFromFile(audio_file);
//    .then(
//        (inbuf) =>console.log("Done.")
//        );
//    
//    .then(
//	(buf) => {
//        console.log("buf loaded: "+buf);
//	    const feats = audio_ddsp.memCheck(buf);
//        console.log("feats extracted: "+feats);
//	    const audio_out = sampleDDSP(feats);
//        console.log("audio generated: "+audio_out);
//	    return audio_out;
//	});
}

async function sampleDDSP(feats) {
    return await audio_ddsp.synthesize(feats);
}

async function init(){
//    await audio_ddsp.initialize().then(	() =>
//        console.log("audio_ddsp initialized.")
//    );
}

init();

