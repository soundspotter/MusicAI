# Assignment 3b: Synthwave / New Wave — Algorithmic Full Track

**Due:** End of Week 3
**Format:** Individual assignment (more substantial — counts as primary Week 3 assignment)
**Focus:** Algorithmic composition, song structure, 1980s electronic pop

## Overview

Implement a synthwave or new wave track — in the style of Jarre, Depeche Mode, Pet Shop Boys, New Order, OMD, or contemporaries — using **algorithmic methods throughout**. Every musical element must vary appropriately over time and follow a clear song structure from intro through outro.

This assignment integrates everything from weeks 1–3: synthesis (FM, subtractive, percussion), process/variation (algorithmic variation, not static loops), and structure (Markov chains, constrained sequences, or scripted forms). The target is a convincing, listenable track, not a demo or proof-of-concept.

## Song Structure

Your piece must move through a standard pop song structure. At minimum include these sections in this order:

```
Intro → Verse → Chorus → Verse → Chorus → [Bridge/Middle 8] → Chorus → Outro
```

Optional additions: pre-chorus, breakdown, extended outro. Total duration: **3–5 minutes**.

Each section transition must be explicit in your code — a listener should be able to hear where you are in the form.

## Musical Layer Requirements

All four layers must be present and must **vary appropriately** between sections:

### 1. Melody
- Algorithmic generation: use Markov chains (trained on your chosen style), constrained pitch sequences, or a parameterized rule
- Melody should differ between verse and chorus (pitch range, rhythmic density, or contour)
- Bridges/middle 8 should introduce a contrasting melodic idea

### 2. Accompaniment / Chords
- Harmonic support via arpeggios, pad chords, or stabs
- Chord voicings or progressions should change between sections
- Use SC's Scale/Chord classes or define your own voicings

### 3. Bass
- Follows the harmonic rhythm
- Bass line should be more active in verses than choruses (or vice versa — make a musical choice)
- Bass synth should be distinct from the melody synth (different filter, envelope, or synthesis type)

### 4. Percussion
- Synthesized drum sounds (from your Assignment 1b/2b work, or fresh)
- Must include the algorithmic drummer behaviors: groove, fill at phrase ends, drop for verse/bridge contrast, build into choruses
- Tempo: 100–140 BPM is typical for the genre; choose something that suits your piece

## Synthesis Requirements

- At least **3 distinct SynthDefs** (e.g., lead synth, pad/chord synth, bass synth — plus percussion voices)
- At least one **FM or subtractive synthesis** voice
- At least one **reverb or delay** effect on at least one voice
- Classic synthwave/newwave timbres to explore: Juno-106 style chorus pad, DX7 FM bell/bass, OB-Xa lead, gated reverb snare, 808 kick

## Algorithmic Requirements

At least **two** of these algorithmic techniques must be operative in the piece:

- **Markov chain** for melody or chord progression generation
- **Constrained search** for voice leading or counterpoint between melody and bass
- **Euclidean rhythm** for hi-hat or percussion pattern
- **Process/phasing** as a texture or transition effect
- **Probabilistic variation** for ornaments, fills, or textural elements (e.g., each bar has a 20% chance of adding a hi-hat variation)

## Deliverables

1. **`.scd` or `.rb` file** — full implementation, well-commented
2. **Audio recording** (3–5 minutes) — the complete piece
3. **Written report** (400–500 words) covering:
   - **Song map**: List each section, its bar length, and the key algorithmic/musical events in it
   - **Algorithmic methods**: Which two (or more) techniques did you use? How and where do they operate?
   - **Synthesis choices**: What synths did you use? What timbral qualities were you aiming for, and how did you achieve them?
   - **What works / what doesn't**: Honest self-assessment. What would you change with more time?

## Grading

| Category | Points |
|----------|--------|
| Song structure (all required sections present, audible transitions) | 15 |
| All four layers (melody, accompaniment, bass, percussion) with appropriate variation | 15 |
| Algorithmic methods (at least 2 correctly implemented) | 15 |
| Synthesis quality (at least 3 SynthDefs; appropriate genre timbres) | 10 |
| Musical result (listenable, cohesive, intentional) | 10 |
| Written report (song map, methods, synthesis, self-assessment) | 15 |
| **Total** | **80** |

## Tips

- **Plan first.** Write out the song map (section, bars, key events) before you open SC. This is a complex piece — improvising the structure in code is much harder.
- **Modular design.** Use `Pdef` for all patterns and organize by section. Functions like `~playVerse.()` and `~playChorus.()` that swap in the right patterns make debugging much easier.
- **Tempo and key.** Lock these early. New wave is often minor or Dorian; synthwave leans toward minor with chromatic descents. 110–130 BPM works for most styles.
- **The chorus needs to lift.** The most common mistake is choruses that sound the same as verses. The chorus should be higher, denser, brighter, or louder than the verse — do at least two of these.
- **A gated reverb snare** is highly genre-appropriate. Implement it as a SynthDef with a short decaying reverb (`FreeVerb` with low `room` and `mix` cut short by an envelope).
- **Reference tracks** to analyze: Jean-Michel Jarre *Oxygène IV*, Depeche Mode "Just Can't Get Enough" or "Everything Counts", Pet Shop Boys "West End Girls", New Order "Blue Monday", OMD "Enola Gay".
