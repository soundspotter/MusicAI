# Activity 2a: Implement and Respond to a Process Music Work

**Format:** Short assignment (take-home)
**Due:** Mid-week 2 (before Thursday class)
**Focus:** Process and ambient music — Reich, Eno, Riley, or contemporaries

## Overview

Choose one work from the list below, implement it (or a faithful approximation of it) in SuperCollider or Sonic Pi, and write a short response connecting the compositional process to the musical result.

The emphasis here is on *understanding by doing*: implementing a piece yourself forces you to engage with its structure at a level that listening alone doesn't.

## Choose One Work

| Composer | Work | Process |
|----------|------|---------|
| Steve Reich | *Piano Phase* (1967) | Two identical patterns, one gradually accelerating until it realigns one note-position ahead |
| Steve Reich | *Clapping Music* (1972) | One fixed pattern; the other shifts right by one 16th note every 12 bars |
| Terry Riley | *In C* (1964) | Ensemble cycles through 53 melodic figures at independent rates against a pulse |
| Brian Eno | *Discreet Music* (1975) | Long-delay tape loop with gradual filtering and regeneration |
| Brian Eno / Harold Budd | *The Plateaux of Mirror* (1980) | Sparse piano with deep reverb; ambient erasure of articulation |
| Steve Reich | *Music for 18 Musicians* (1976) | Phasing + breathing cycles + harmonic evolution (implement one section) |
| Alvin Lucier | *I Am Sitting in a Room* (1969) | Room resonance accumulates through recording/playback cycles; implement digitally |
| Julius Eastman | *Evil Nigger* (1979) | Additive process: single motif accumulates layers and register; implement one section |

You are not limited to this list — if you have a piece in mind, check with the instructor.

## Requirements

1. **Working implementation** in SC or Sonic Pi that demonstrates the core compositional process. A 1–3 minute excerpt is sufficient; you do not need to implement the full piece.

2. **Faithful to the original process**: The point is to understand *how* it works, not to make it sound exactly like the recording. Prioritize mechanical accuracy over sonic resemblance.

3. **At least one variation or extension**: Once the process is running, modify one parameter (tempo, pitch material, loop length, register, decay time, etc.) and note what changes. This is your "response" to the piece.

## Deliverables

1. **`.scd` or `.rb` file** — your implementation
2. **Audio recording** (1–3 min) of your implementation
3. **Written response** (200–300 words):
   - What is the compositional rule or process you implemented?
   - What did implementing it reveal that listening alone didn't?
   - What variation did you introduce, and how did it change the musical character?
   - Does the process feel "compositional" or "automatic" to you — and does that matter?

## Grading

| Category | Points |
|----------|--------|
| Implementation (process correctly rendered) | 12 |
| Audio (demonstrates the process audibly) | 8 |
| Written response (insight, engagement) | 10 |
| **Total** | **30** |

## Connection to Week 2 Themes

The assigned readings — Reich's "Music as a Gradual Process" (1968) and Eno's *Discreet Music* liner notes — argue that making the process perceptible is itself a compositional value. As you code, ask whether a listener could hear the rule operating. That question recurs throughout the course: Markov chains (Week 3) and transformers (Week 5) also generate music via rules, but the rules are less legible. Process music is the clearest case of algorithmic composition as aesthetic statement.
