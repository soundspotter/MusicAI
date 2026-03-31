# Assignment 2: Process Music / Ambient Composition

**Due:** End of Week 2
**Tools:** SuperCollider (`.scd`) or Sonic Pi (`.rb`) — your choice

## Task

Create a **3--5 minute** ambient or process music piece in SuperCollider. Choose **ONE** of the following approaches:

### Option A -- Ambient Loops (Eno style)

Create a piece with 2--3 melodic loops of different lengths that drift in and out of phase. Use reverb and delay to blur boundaries between notes. The piece should evolve slowly and create a contemplative atmosphere.

### Option B -- Phasing Process (Reich style)

Create a piece where two or more identical patterns gradually shift phase. The piece should make the phasing process audible -- the listener should be able to hear the patterns moving in and out of alignment.

### Option C -- Generative Soundscape

Design a system that generates an evolving soundscape using at least 2 different synthesis techniques (subtractive, FM, granular, etc.). The piece should feel organic and ever-changing while maintaining a consistent mood.

## Requirements

1. Use at least **2 different synthesis voices** — SynthDefs in SuperCollider, or distinct `synth:` / `use_synth` voices in Sonic Pi (can be from the course examples or your own)
2. All patterns defined with **Pdef** (SuperCollider) or **live_loop** (Sonic Pi) so they can be live-updated
3. **Audio recording** of 3--5 minutes — bounce from SC (`s.record`/`s.stopRecording`) or use Sonic Pi's built-in recording toolbar, or record with Audacity
4. The piece should **evolve over time** -- not just loop static patterns

## Deliverables

- `.scd` or `.rb` file with your SuperCollider or Sonic Pi code
- Audio recording (WAV or MP3, 3--5 minutes)
- Written reflection (200--300 words) discussing:
  - Your compositional process and design decisions
  - How your system generates variation over time
  - What you learned about the relationship between process and musical result

## Grading

| Category | Points |
|----------|--------|
| Technical implementation (SynthDefs, patterns, SC fluency) | 15 |
| Musical result (aesthetic quality, evolution, cohesion) | 10 |
| Reflection (insight, clarity, engagement with ideas) | 10 |
| Documentation (code comments, clear structure) | 5 |
| **Total** | **40** |
