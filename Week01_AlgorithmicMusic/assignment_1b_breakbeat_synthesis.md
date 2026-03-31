# Assignment 1b: Breakbeat from Scratch

**Due:** End of Week 1
**Format:** Individual short assignment
**Focus:** Drum synthesis, TR-808 style sounds

## Overview

Choose one of the breaks listed below and recreate it using **synthesized drum sounds only** — no samples of the original recordings.

You must build the drum sounds from synthesis primitives (oscillators, noise, envelopes, filters), not from pre-recorded loops or breakbeat sample packs. The TR-808 SynthDefs provided in the course materials are a good starting point.

## Breakbeat Options

Choose any one of the following. They are grouped roughly by character — pick one whose drum sound interests you to synthesize, not necessarily the one you know best.

**Hip-hop / funk foundations**
- **Funky Drummer** — James Brown, *In the Jungle Groove* (1986). Drummer: Clyde Stubblefield. Tight, syncopated; includes ghost notes, rim shot, cowbell accent.
- **Think (About It)** — Lyn Collins (1972). Drummer: Jabo Starks. High-energy, clean break; famously interpolated in "It Takes Two."
- **Impeach the President** — The Honey Drippers (1973). Distinctive light snare opening; one of the most-sampled patterns in hip-hop.
- **Synthetic Substitution** — Melvin Bliss (1973). Crisp, versatile; one of the most-sampled breaks ever recorded.
- **Ashley's Roachclip** — Soul Searchers (1974). Funk-driven, laid-back groove.
- **The Champ** — The Mohawks (1968). Foundational funk break; widely used in DJ culture.
- **Get Up, Get Into It, Get Involved** — James Brown (1970). High-energy JB pattern, less syncopated than Funky Drummer.
- **Hot Pants** — James Brown (1971). Staple in jungle and drum & bass production.
- **Cold Sweat** — James Brown (1967). Fast-paced; one of the earliest funk breaks.
- **Message from the Soul Sisters** — Vicki Anderson (1970). Sought-after funky break with a strong snare character.

**Early hip-hop / electro**
- **Apache** — Incredible Bongo Band (1973). Features bongos alongside heavy kick and snare; a staple of early hip-hop and electro.

**Drum & bass / jungle**
- **Amen Break** — The Winstons, "Amen, Brother" (1969). Drummer: G.C. Coleman. Complex snare pattern with ghost notes; definitive break of jungle and drum & bass. [See also: Nate Harrison, "Can I Get An Amen" (2004) — a 20-minute audio essay on its cultural history, available free online.]

**Rock**
- **When the Levee Breaks** — Led Zeppelin (1971). Drummer: John Bonham. Massively influential; heavy, roomy sound recorded in a stairwell. Note: the synthesis challenge here is the room character as much as the rhythm.

**Not sure which to pick?** The Amen Break is the hardest to transcribe accurately (ghost notes, complex snare). Impeach the President and Synthetic Substitution are clean and well-suited for a first attempt. Apache is a good choice if you want to work with non-standard percussion voices.

## Requirements

1. **Synthesized sounds only**: Kick, snare, hi-hat (open and closed), and any other percussive elements must be synthesized. You may use the course TR-808 SynthDefs (`09_percussion.scd`) or write your own.

2. **Accurate rhythm**: Your pattern should be a faithful rhythmic transcription of the original break. Listen carefully to the original and notate the pattern before coding it. Pay attention to ghost notes, swing, and dynamic variation.

3. **At least 16 subdivisions of a beat**: Use a 16th-note grid (or finer if the break requires it).

4. **At least 4 distinct drum voices**: e.g., kick, snare, closed hi-hat, open hi-hat. Some breaks require additional voices — Apache needs bongos; Funky Drummer has a rim shot and cowbell accent; the Amen Break has a complex layered snare. Match whatever voices the original break uses.

5. **Loop cleanly**: The pattern should loop seamlessly at an appropriate tempo.

## Deliverables

1. **`.scd` or `.rb` file** — your synthesized breakbeat implementation
2. **Audio recording** (30–60 seconds, looped) — WAV or MP3
3. **Short write-up** (150–200 words):
   - Which break did you choose, and why?
   - How did you approach transcribing the rhythm? What was the hardest part to get right?
   - What synthesis choices did you make for each drum sound (e.g., pitch envelope for the kick, noise color for the snare)? How do your sounds compare to the originals?

## Grading

| Category | Points |
|----------|--------|
| Synthesized sounds (no samples; at least 4 distinct voices) | 10 |
| Rhythmic accuracy (faithful to the original break) | 10 |
| Audio quality (sounds musical, loops cleanly) | 5 |
| Write-up (synthesis choices explained, honest comparison) | 5 |
| **Total** | **30** |

## Tips

- Listen to the original with headphones and tap out the pattern before you start coding.
- Use a 16-step array (or Pbind with a 16th-note base duration) to lay out the pattern visually.
- Ghost notes on the snare are quieter hits (0.2–0.4 amplitude). Use a separate pattern event or a `\amp` array.
- Kick synthesis: a short pitch sweep from ~120 Hz down to ~50 Hz with a punchy envelope. Snare synthesis: layered noise burst + pitched transient. Open hi-hat: filtered noise with a longer decay. Bongo (Apache): narrow-band resonant noise with a fast pitch drop.
- Swing (shuffle feel) can be approximated by alternating slightly longer and shorter 16th-note durations.
- You do not need to match the original perfectly — a convincing approximation that demonstrates synthesis understanding is the goal.

## Reference

Recording details and cultural context for each break are noted in the Breakbeat Options section above. For a broader history of breakbeat culture, see Joseph Schloss, *Making Beats: The Art of Sample-Based Hip-Hop* (2004).
