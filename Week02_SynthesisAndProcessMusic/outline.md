# Week 2: Synthesis & Process Music

## Learning Goals

- Understand subtractive, FM, and granular synthesis techniques
- Implement generative ambient music in SuperCollider or Sonic Pi
- Understand process music (Reich, Eno) and its relationship to algorithmic thinking
- Create multi-voice generative soundscapes using layered loops and stochastic timing
- Critically evaluate how synthesis technique shapes musical style and genre

## Tuesday — Sound Design & Synthesis

**10:10–11:00**

| Time | Activity |
|------|----------|
| 10:10 | **Lecture**: Subtractive synthesis — oscillators (Saw, Pulse, SinOsc), filters (MoogFF, RLPF, BPF), ADSR envelopes; live demo in SC/Sonic Pi |
| 10:30 | **Group sound-matching challenge**: each group receives a target sound (bass guitar, brass stab, string pad, kick drum) and must design a synth patch to match it using subtractive or FM synthesis in SC/Sonic Pi |

**Break (11:00–11:10)**

**11:10–12:00**

| Time | Activity |
|------|----------|
| 11:10 | Groups present their patches; class identifies which target each group matched; brief peer critique |
| 11:30 | **Lecture**: Granular synthesis — grains, density, spray, time-stretching; demo in SC |
| 11:50 | Preview reading: Steve Reich "Music as a Gradual Process" — 3-minute solo read of key passages; each student writes one reaction sentence |

## Thursday — Process Music & Algorithmic Practice

**10:10–11:00**

| Time | Activity |
|------|----------|
| 10:10 | **Guided close listening**: Piano Phase, Discreet Music, In C — guided questions on paper (what changes over time? what stays fixed? is there a score?); discuss in pairs |
| 10:40 | Full-class discussion: what is a musical process? Is it the same as an algorithm? What is the composer's role when the music "runs itself"? |

**Break (11:00–11:10)**

**11:10–12:00**

| Time | Activity |
|------|----------|
| 11:10 | **Live demo**: Reich phasing in SC/Sonic Pi (`reich_phasing.scd`) — gradual tempo offset and discrete phase shifts |
| 11:20 | **Live demo**: Eno-style ambient loops (`ambient_loops.scd`) — stochastic timing, evolving parameters |
| 11:30 | **Activity 2a in-class start**: students choose a process work and begin implementing in SC/Sonic Pi; instructor circulates (work continues as take-home). Introduce Assignment 2b (Algorithmic Drummer, see `assignment_2b_algorithmic_drummer.md`). |

## Code Examples

- `code/subtractive_synth.scd` — Oscillators, filters, envelopes, Moog SynthDef, Pbind patterns
- `code/fm_synthesis.scd` — FM basics, bell tones, organ, dynamic index modulation
- `code/ambient_loops.scd` — Eno's Discreet Music ported to SC, Music for Airports style
- `code/reich_phasing.scd` — Piano Phase: gradual tempo offset, discrete phase shifts, automatic walk

## Discussion Questions

1. How does process music relate to algorithms? Is a musical process the same as a computer algorithm?
2. Is ambient music "composed" or "designed"? Where is the boundary between composing notes and designing systems?
3. What is the relationship between synthesis technique and musical style? Why do certain synth architectures lend themselves to certain genres?
4. Reich said he wanted to make the musical process perceptible to the listener. Does knowing the process change how you hear the music?

## Readings

- Steve Reich, "Music as a Gradual Process" (1968)
- Brian Eno, liner notes to *Discreet Music* (1975)

## Listening

- Brian Eno — "Discreet Music" (1975)
- Brian Eno — "Music for Airports 1/1" (1978)
- Steve Reich — "Piano Phase" (1967)
- Steve Reich — "Come Out" (1966)
- Terry Riley — "In C" (1964, any recording)
