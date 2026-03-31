// Music and AI, 2023
// Dartmouth College
// CS 89/189 MUS14, Prof. Michael Casey

function to_magenta(pitches, durations, bpm=120, timesig=[4,4], ticksPerQuarter=220){
    if (pitches.length != durations.length)
	throw Error("pitches.length != durations.length: "+pitches.length+" != "+durations.length)
    let sequence = {
	ticksPerQuarter: ticksPerQuarter,
	totalTime: 0.0,
	timeSignatures: [{time: 0, numerator: timesig[0], denominator: timesig[1]}],
	tempos: [{time: 0, qpm: 120}],
	notes: [ ]
    }   
    s = 0
    for(let i = 0; i < pitches.length; i++){
	d = durations[i]
	sequence.notes.push({pitch: pitches[i], startTime: s, endTime: s+d})
	s += d
    }
    sequence.totalTime = s
    return sequence
}

function to_sonicpi(sequence){
    console.log(sequence)
    stepDur = 60.0 / (sequence.tempos[0].qpm * sequence.quantizationInfo.stepsPerQuarter)
    pitches = []
    starts = []
    durations = []
    for(let n of sequence.notes){
	pitches.push(n.pitch)
	starts.push(n.quantizedStartStep*stepDur)
	durations.push(n.quantizedEndStep*stepDur - n.quantizedStartStep*stepDur)
    }
    return {pitches:pitches, starts:starts, durations:durations}
}
