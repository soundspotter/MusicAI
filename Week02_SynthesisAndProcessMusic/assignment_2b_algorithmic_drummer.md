# Assignment 2b: Algorithmic Drummer

**Due:** End of Week 2
**Format:** Individual assignment
**Focus:** Algorithmic variation, musical form, breakbeat as material

## Overview

Starting from your breakbeat (Assignment 1b), build an **algorithmic drummer** that performs it as a living musician would — varying fills, dropping out, building tension, and shaping a convincing formal arc over 2–4 minutes.

The goal is not to randomize everything, but to make *musically intelligent* decisions about when to vary, when to stay consistent, how to build, and when to resolve. Think about how a real drummer plays: they establish a groove, hold it for a phrase, vary slightly to signal a section change, and execute a fill before the downbeat of the chorus.

## Requirements

### 1. Base groove
Your breakbeat from Assignment 1b is your base pattern. It should run stably as the default state.

### 2. Phrase-level structure
Organize the performance into **musical phrases** (typically 4 or 8 bars). The drummer should behave differently at phrase boundaries — something changes at bar 5, 9, 13, etc.

### 3. Four behavioral modes
Implement at least these four modes, and control when they occur algorithmically:

| Mode | Description |
|------|-------------|
| **Groove** | Default; the base pattern runs with minor variation (e.g., slight amp variation, occasional ghost notes) |
| **Fill** | A departure at the end of a phrase (typically bar 4 or 8); pattern changes significantly before returning to groove on the downbeat |
| **Drop** | One or more voices drop out (e.g., kick goes quiet; only hi-hat remains) — creates space and tension |
| **Build** | Density or intensity increases over several bars toward a peak (e.g., more frequent hits, additional voices entering, tempo slightly increasing or rushing) |

### 4. Formal arc
The full 2–4 minute performance should have a discernible **macro-form** — for example:

```
Intro (sparse) → Groove established → Drop → Groove returns → Build → Peak → Groove → Outro (strips down)
```

This form does not need to follow a specific song structure, but a listener should feel it moving through stages, not just looping indefinitely.

### 5. Synthesized sounds
Continue using synthesized drum sounds (no pre-recorded break samples). You may refine your sounds from 1b.

## Technical Approaches

You have several options for controlling behavior over time — choose what works for your implementation:

- **State machine**: A variable tracks the current mode; transitions happen at phrase boundaries based on probability or a scripted sequence
- **Probability scheduling**: Each phrase boundary rolls a weighted die to choose the next mode
- **Scripted form**: A hard-coded sequence of modes that play out over the full piece
- **Pattern replacement**: Use `Pdef` to swap in different patterns at phrase boundaries

Any of these is valid; the musical result matters more than the implementation strategy.

## Deliverables

1. **`.scd` or `.rb` file** — well-commented implementation
2. **Audio recording** (2–4 minutes)
3. **Written description** (200–300 words):
   - What is the formal arc of your piece? (Describe it in words or diagram it)
   - How did you implement the transitions between modes? What triggers a fill, a drop, a build?
   - What was the hardest musical behavior to make sound convincing? How did you address it?

## Grading

| Category | Points |
|----------|--------|
| Base groove and synthesized sounds | 8 |
| Four behavioral modes (groove, fill, drop, build) | 12 |
| Macro-form / arc (perceptible shape over the full recording) | 10 |
| Written description (clear explanation of design) | 10 |
| **Total** | **40** |

## Tips

- The **fill** is the most important behavioral moment. It signals phrase endings and section changes. A fill that doesn't land on the downbeat of the next section sounds wrong. Code the fill to end on beat 1.
- **Drop** is most effective after an established groove. Dropping out too early, before the listener has internalized the pattern, doesn't create tension — it just creates absence.
- **Build** can be as simple as increasing hi-hat density over 4 bars, or adding a ride cymbal that crescendos. It does not need to be complex.
- Listen to recordings of your chosen break being used in actual tracks to study how real drummers/producers vary it.
