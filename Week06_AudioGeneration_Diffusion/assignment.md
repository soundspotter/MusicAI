# Assignment 6: Generate, Separate, Remix

**Due:** End of Week 6
**Points:** 40

## Overview

In this assignment you will build a creative pipeline that combines AI music generation with source separation. You will generate original music with MusicGen, decompose it into stems with HTDemucs, and produce a remix by recombining stems from different generations. The goal is to develop both technical fluency with these tools and a critical ear for evaluating AI-generated audio.

## Pipeline

1. **Generate** 3 pieces with MusicGen using different text prompts
2. **Separate** each piece into stems using HTDemucs
3. **Remix** by combining stems from different generations into a new piece
4. **Critique** the results in a written reflection

## Requirements

### 1. MusicGen Generations (10 pts)

- Generate at least 3 distinct pieces using MusicGen (small or melody model)
- Each piece should use a different, thoughtful text prompt
- Prompts should target different genres, moods, or instrumentation
- Generate at least 10 seconds per piece (max_new_tokens >= 512)
- Document your prompt design choices: why did you choose each prompt? What musical outcome were you targeting?

### 2. Source Separation (5 pts)

- Run HTDemucs on all 3 generated pieces
- Produce 4-stem separations (drums, bass, other, vocals)
- Visualize at least one separation as spectrograms (original vs. stems)

### 3. Creative Remix (10 pts)

- Create 1 remix that combines stems from at least 2 different generations
- For example: drums from generation 1 + bass from generation 2 + melody from generation 3
- You may adjust stem volumes, apply simple effects, or time-align stems
- The remix should sound musically intentional, not random

### 4. Written Critique (10 pts)

Write a 400-word reflection addressing:

- **Generation quality**: How realistic or musically coherent are the MusicGen outputs? What artifacts do you hear?
- **Prompt sensitivity**: How did different prompts affect the output? Which prompts worked well and which did not?
- **Separation quality**: How clean are the separated stems? What artifacts does HTDemucs introduce?
- **Creative potential**: Is this generate-separate-remix pipeline useful for music production? What are its limitations?
- **Comparison**: How does AI-generated audio compare to human-produced music in terms of structure, timbre, and expressiveness?

### 5. Technical Execution (5 pts)

- Clean, well-commented notebook code
- All cells run without errors
- Outputs are clearly labeled and organized

## Deliverables

Submit the following:

1. **Colab notebook** (.ipynb) containing all code for generation, separation, and remixing
2. **Audio files**: all 3 MusicGen generations (.wav), separated stems, and final remix (.wav)
3. **Written critique** (400 words) -- include in the notebook as markdown cells or as a separate document

## Grading Breakdown

| Component | Points |
|-----------|--------|
| Generation quality and prompt design | 10 |
| Source separation | 5 |
| Remix creativity | 10 |
| Written critique | 10 |
| Technical execution | 5 |
| **Total** | **40** |

## Tips

- Start with `musicgen-small` for faster iteration, then try `musicgen-melody` for melody conditioning
- Be specific in your prompts: "Upbeat funk with slap bass, clavinet, and tight drums at 110 BPM" works better than "funk music"
- Listen to the separated stems individually before remixing -- some stems may be empty or noisy
- When remixing, consider key compatibility and tempo alignment between stems
- Save intermediate outputs so you do not have to regenerate everything if Colab disconnects
