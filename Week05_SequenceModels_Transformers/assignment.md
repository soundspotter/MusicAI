# Assignment 5: Symbolic Music Generation with Neural Networks

**Due:** End of Week 5
**Points:** 40

## Task

Fine-tune or prompt a symbolic music generation model. Generate and critically evaluate 3 pieces.

## Requirements

1. **Model Selection**: Use one of the models from class:
   - Your own trained LSTM (from `lstm_music.ipynb`)
   - Your mini-transformer (from `miditok_training.ipynb`)
   - SkyTNT midi-model (from `midi_model_demo.ipynb`)
   - Anticipatory Music Transformer (from `music_transformer.ipynb`)

2. **Generation**: Create at least 3 pieces with different settings:
   - Vary temperature (e.g., 0.5, 1.0, 1.5)
   - Vary length or prompt
   - Try different seeds or starting notes

3. **Critique**: For each piece, write a 100-word critique addressing:
   - Melodic coherence: Does it sound like music?
   - Rhythmic consistency: Is the timing natural?
   - Long-term structure: Is there repetition, development, or form?
   - Comparison to human composition

4. **Comparison**: Compare your neural model's output to your Week 3 Markov model. What improved? What got worse?

## Also Due: Final Project Proposal

Submit a 1-page proposal for your final project:
- **Title** and brief description
- **Approach**: What techniques/tools will you use?
- **Timeline**: Key milestones for weeks 6-9
- **Resources needed**: Datasets, GPU time, hardware

## Deliverables

- Colab notebook (.ipynb) with generation code
- 3 MIDI files + 3 audio renders
- Written analysis (400 words total for critiques + comparison)
- Final project proposal (1 page, separate document)

## Grading

| Component | Points |
|-----------|--------|
| Model usage and generation | 10 |
| Quality of generated output | 10 |
| Critical analysis | 10 |
| Final project proposal | 10 |
| **Total** | **40** |
