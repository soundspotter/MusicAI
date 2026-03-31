# Activity 6a: Prompt Battle

**Week 6 — Tuesday, in class (~20 minutes)**
**Format**: groups of 3, then full-class vote and debrief

---

## Overview

All groups have the same creative brief. Each group writes a different text prompt to achieve it, and generates audio with MusicGen. The class hears each result blind (without seeing the prompts) and votes on which sounds best. Then the prompts are revealed. The goal is to develop intuitions about how MusicGen interprets language.

---

## The Brief

> **Generate: a melancholy 80s synth ballad.**
>
> The result should feel emotionally heavy and introspective. It should use synthesizer sounds typical of the early-to-mid 1980s (pads, arpeggiated sequences, gated reverb). Slow to moderate tempo. Minor key. The production style should feel era-appropriate — not modern polish.

---

## Your Group's Task (5 min)

Write a single text prompt for MusicGen that you believe will best achieve the brief above. Your prompt can be as long or short as you like. You may reference specific artists, genres, production techniques, instruments, moods, tempos, or anything else you think MusicGen will respond to.

**Your prompt:**

```
[write your prompt here]
```

**Your reasoning** (1–2 sentences: why did you write it this way?):

---

## Generation & Blind Vote (10 min)

The instructor collects all prompts and generates one audio clip per group (same model settings, same duration). The class hears each clip labeled only by number. Each person votes for the best result — write your vote below before the reveal.

**My vote:** Clip number ___

**Why:** (one sentence)

---

## Reveal & Debrief (5 min)

After the prompts are revealed, discuss as a class:

1. Which prompt features correlated most strongly with the winning result?
2. Was anything in the prompts surprisingly effective? Surprisingly ineffective?
3. Did any group try a very different strategy (e.g., very short vs. very detailed, artist names vs. technical descriptors)? Did that strategy pay off?
4. What does this experiment reveal about how MusicGen maps language to audio?

---

## Reflection Questions (individual, ~2 min)

Write one sentence for each:

- One thing you would change about your prompt now that you've heard the results:
- One aspect of "80s melancholy synth ballad" that seemed impossible to capture in language:
- Does text prompting feel like *composing*? Why or why not?

---

## Instructor Notes

**Logistics**: collect prompts digitally (Google Form or shared doc) so you can copy-paste into the Colab without students seeing each other's prompts during generation. Run all generations before playing any.

**MusicGen settings**: use `musicgen-medium` or `musicgen-large`; 30-second clips; same seed across generations so only the prompt varies (if MusicGen API allows seed control, use it — otherwise note that results may vary even for the same prompt).

**Variants of the brief** (rotate across semesters):
- A driving krautrock motorik beat with a hypnotic bassline
- An anxious post-minimalist string quartet passage
- A euphoric early rave track with a simple piano hook
- A sparse country ballad with pedal steel and fingerpicked acoustic guitar

**Key teaching point**: the gap between what language *describes* and what a model *hears* reveals the limits of text-to-music as a compositional interface. The prompt battle makes that gap visible and discussable.
