# Week 3: Markov Models & Information Content

## Learning Goals

- Understand MIDI and OSC protocols for digital music communication
- Implement nth-order Markov chains for melody generation in SC or Sonic Pi
- Understand multiple viewpoint systems and how they combine musical dimensions
- Compute and interpret information content (surprise) in music using Pearce's IDyOM framework
- Apply constrained composition with voice-leading rules
- Engage with John Cage's indeterminate music as an algorithmic/philosophical counterpoint

## Tuesday — Representation, Markov Chains & Cage

**10:10–11:00**

| Time | Activity |
|------|----------|
| 10:10 | **Lecture**: MIDI and OSC protocols — digital music representation, event model, pitch/duration encoding; live demo (`midi_osc_basics.scd`) |
| 10:25 | **Markov chain theory + live demo**: order 1, 2, 3 comparison; train on a small melody corpus (`nth_order_markov.scd`) |
| 10:45 | **Hands-on**: students train a Markov model on a short melody of their choice; change the order and observe differences |

**Break (11:00–11:10)**

**11:10–12:00**

| Time | Activity |
|------|----------|
| 11:10 | **Group listening**: compare order-1, order-2, order-3 Markov outputs from the same source melody — describe the differences, vote on which sounds most musical and why |
| 11:30 | **Activity 3a in-class**: small groups read two rules from Cage's *Song Books*; each group designs their own 1-sentence compositional rule ("a performer will..."); share with class. Introduce Activity 3a take-home (see `activity_3a_cage_songbook.md`). |

## Thursday — Information Content, Sampling & Synthwave

**10:10–11:00**

| Time | Activity |
|------|----------|
| 10:10 | **Lecture**: Information content and IDyOM — Pearce's model of musical expectation; what IC measures; high-IC = surprise, low-IC = predictability |
| 10:30 | **IC group activity**: given a familiar melody (Happy Birthday, Ode to Joy, or similar), students first predict on paper where IC will be high or low; then instructor shows computed IC plot; compare predictions to actual values |

**Break (11:00–11:10)**

**11:10–12:00**

| Time | Activity |
|------|----------|
| 11:10 | **Synthwave listening + analysis**: hear 3 tracks (e.g., Jarre, Depeche Mode, New Order); in groups, map the song structure and identify each layer (melody, bass, pads, percussion, arpeggios) |
| 11:35 | Full-class discussion: what algorithmic methods (Markov, Euclidean, process) could generate each layer? What would you need to add to model the synthwave aesthetic? |
| 11:50 | Assignment 3b (Synthwave/New Wave synthesis, see `assignment_3b_synthwave_newwave.md`) overview and Q&A |

## Code Files

| File | Description |
|------|-------------|
| `code/midi_osc_basics.scd` | MIDI and OSC protocol basics in SuperCollider |
| `code/nth_order_markov.scd` | Nth-order Markov chain melody generation |
| `code/multiple_viewpoint.scd` | Multiple viewpoint model combining pitch, duration, interval |
| `code/information_content.scd` | Information content / surprise measurement and plotting |
| `code/sampling_strategies.scd` | Greedy, temperature, top-k, and nucleus sampling |
| `code/counterpoint.scd` | Constrained composition and counterpoint |
| `code/voice_leading.scd` | Smooth voice leading for chord progressions |

## Discussion Questions

1. How does Markov order affect the balance between novelty and coherence?
2. Can we quantify musical surprise? Is IC a good model of listener experience?
3. How do sampling strategies (greedy, temperature, nucleus) affect perceived creativity in generated melodies?
4. What are the limitations of Markov models for music generation? What would a model need to capture that they miss?
5. Cage used chance procedures to *remove* composer preference. How does that differ from a Markov model, which *learns* composer preference from a corpus?

## Readings

- Bown, Ch. 3: "Generative Algorithms"
- Pearce & Wiggins, "Auditory Expectation: The Information Dynamics of Music Perception and Cognition" (2012)

## Listening

- **John Cage** — *Song Books* (1970), selected realizations
- **Synthwave/New Wave** (in-class Thursday): Jean-Michel Jarre, Depeche Mode, New Order
- **Xenakis** — *Achorripsis* (1957) — stochastic music
