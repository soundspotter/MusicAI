# Assignment 3: Nth-Order Markov Melody Generator with Information Content Analysis

**Due:** End of Week 3
**Points:** 40
**Tools:** SuperCollider (`.scd`) or Sonic Pi (`.rb`) — your choice

## Task

Build an nth-order Markov melody generator in SuperCollider or Sonic Pi. Train it on a corpus of melodies, compare outputs at different orders, and compute information content.

## Requirements

1. **Markov Model (order 2+):** Train a Markov model of at least order 2 on a corpus of 3 or more melodies. You may use the provided corpus or supply your own (MIDI note sequences).

2. **Generate at Multiple Orders:** Generate melodies at orders 1, 2, and 3. Record audio of all three outputs.

3. **Sampling Strategies:** Implement at least 2 sampling strategies (e.g., temperature + top-k) and demonstrate how they affect the output.

4. **Information Content:** Compute IC for both the original training melodies and your generated melodies. Report mean IC and identify the most surprising moments.

5. **Code Documentation:** Include comments explaining your implementation choices --- why you chose your corpus, order, and sampling parameters.

## Deliverables

- **`.scd` or `.rb` file** with your Markov generator (well-commented)
- **3 audio recordings** (one per Markov order: order 1, order 2, order 3)
- **Written analysis** (400--500 words) addressing:
  - How does order affect output quality? Which order sounds best and why?
  - Compare mean IC between original and generated melodies at each order
  - How do different sampling strategies affect the musical results?
  - At what order does the generator start reproducing the training data verbatim?

## Bonus (5 pts)

Implement a multiple viewpoint model that combines pitch and rhythm viewpoints (see `multiple_viewpoint.scd` in SC, or extend your Ruby hash to key on `[pitch, duration]` pairs in Sonic Pi). Generate a melody using the combined model and compare it to single-viewpoint output.

## Grading

| Component | Points |
|-----------|--------|
| Implementation (model, generation, sampling) | 15 |
| Generated audio (3 recordings, distinct outputs) | 10 |
| Written analysis (depth, clarity, IC comparison) | 10 |
| Code documentation (comments, readability) | 5 |
| **Total** | **40** |
| Bonus: Multiple viewpoint model | +5 |

## Tips

- SC: start with `nth_order_markov.scd` and extend it; use `information_content.scd` as a reference for IC computation. Sonic Pi: implement the Markov table as a Ruby hash, and IC as `-Math.log2(probability)`.
- Try training on melodies with contrasting styles to see how the model blends them
- Recording — SC: `Server.default.record` / `Server.default.stopRecording`. Sonic Pi: built-in recording toolbar or `start_recording` / `stop_recording` / `save_recording`.
- When comparing orders, use the same seed (starting notes) for a fair comparison
