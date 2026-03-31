# Assignment 1: Algorithmic Composition

**Due:** End of Week 1
**Points:** 40 (out of course total)
**Tools:** SuperCollider (`.scd`) or Sonic Pi (`.rb`) — your choice

## Task

Create a short algorithmic composition (1--3 minutes) in SuperCollider or Sonic Pi using **at least two** of the techniques covered this week:

- **Isorhythm** -- Color (pitch sequence) and talea (rhythm sequence) of different lengths
- **Euclidean rhythms** -- At least 2 layered patterns with different k/n values
- **Dice-based / combinatorial selection** -- Randomly selecting from pre-composed material (Mozart dice game approach)

You may combine techniques freely. For example, an isorhythmic melody over Euclidean percussion, or a dice-selected sequence of Euclidean rhythm patterns.

## Requirements

1. **At least 2 independent voices/parts** (e.g., melody + bass, high + mid + low percussion layers)
2. **Use `Pdef` (SuperCollider) or `live_loop` (Sonic Pi) for all patterns** so they can be stopped, modified, and restarted during development
3. **Include comments** explaining your musical choices -- why did you choose these particular color/talea lengths, these Euclidean parameters, this scale, etc.?
4. **The piece should have some sense of form** -- a beginning, development, and ending. This could be as simple as voices entering one at a time and fading out, or as structured as an ABA form.
5. **Record a 1--3 minute audio render.** In SuperCollider: `s.record` / `s.stopRecording`. In Sonic Pi: use the built-in recording button in the toolbar, or `start_recording` / `stop_recording` / `save_recording("filename.wav")`.

## Deliverables

Submit the following three items:

1. **`.scd` or `.rb` file** -- Your SuperCollider or Sonic Pi composition source code
2. **Audio recording** -- `.wav` or `.mp3` file (1--3 minutes)
3. **Written reflection** (200--300 words) answering these questions:
   - What algorithmic choices did you make and why?
   - How does the output differ from what you expected?
   - Where does the "creativity" lie -- in the algorithm, the data (pitch/rhythm material), or the composer's choices in designing the system?

## Grading Rubric

| Category | Points | Criteria |
|----------|--------|----------|
| **Technical implementation** | 15 | Correct use of SC pattern library; at least 2 techniques from this week; clean, runnable code |
| **Musical result** | 10 | Interesting sonic result; sense of form or development; evidence of listening and iteration |
| **Written reflection** | 10 | Thoughtful engagement with questions of algorithmic creativity; specific references to your own piece |
| **Code documentation** | 5 | Clear comments explaining choices; well-organized code structure; readable formatting |
| **Total** | **40** | |

## Tips

- Start simple. Get one pattern working, then add voices.
- SC: use `Pdef` so you can redefine patterns on the fly. Sonic Pi: use `live_loop` with `sync` for coordinated loops.
- Coprime numbers (e.g., 7 and 5, or 11 and 8) create the longest isorhythmic cycles before repetition.
- Scales — SC: `Scale.dorian`, `Scale.phrygian`, `Scale.minor`. Sonic Pi: `:dorian`, `:phrygian`, `:minor` with `use_scale`.
- Record several versions and submit the one you like best.
- The reflection is worth 10 points -- take it seriously. There are no wrong answers, but vague answers will not receive full credit.
