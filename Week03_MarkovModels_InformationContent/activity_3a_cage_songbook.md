# Activity 3a: John Cage — Song Books

**Format:** Short assignment
**Due:** Mid-week 3
**Focus:** Chance operations, rule-based performance, indeterminate notation

## Overview

John Cage's *Song Books* (1970) contains 90 solos for voice, each generated through chance operations and each following a stated rule (printed with the score). The rules range from theatrical instructions to pure sound-making to silent actions. Cage divided them into two categories: **"relevant to music theater"** and **"not relevant to music theater"** (i.e., pure music).

Your task is to implement one *Song Books* solo — or a piece in the spirit of its method — in SuperCollider or Sonic Pi.

## Option A: Implement a Specific Solo

A selection of solos that translate reasonably to code:

| Solo | Rule (paraphrased) | Coding approach |
|------|--------------------|-----------------|
| **Solo 20** | Read aloud from *Thoreau's Journal*; time each word using coin tosses | Random durations from a word sequence; use SC text-to-speech or typed output as guide |
| **Solo 34** | Perform a mix of singing and non-vocal sounds; transitions determined by chance | Markov chain between synthesis modes (vocal-like formant, noise, pitched tone) |
| **Solo 47** | A song of any length; the notes are Thoreau's drawings mapped to pitch | Map a set of coordinates (image-derived or arbitrary) to pitch/time |
| **Solo 68** | Extend the sound of each syllable/note until it becomes noise | Granular re-synthesis or feedback; pitch held then degraded to noise over a random duration |
| **Solo 82** | A sequence of sounds and silences; proportions determined by I Ching | Use hexagram values (integers 1–64 mapped to durations) to control a rest/note sequence |

You are not required to use the actual Thoreau text or I Ching readings. The point is the **compositional rule**, not authenticity to Cage's specific materials.

## Option B: Write Your Own Cage-Style Solo

Design a new 1-page score/rule that:

- States the rule clearly and completely in 1–3 sentences
- Uses chance operations to determine at least one musical parameter (pitch, duration, timbre, silence)
- Is indeterminate in the sense that no two realizations will be identical
- Could be implemented by someone else from your written rule alone

Implement your rule in SC or Sonic Pi and record it.

## Requirements (both options)

1. **Working implementation** that follows the rule
2. **The rule must be operative**: the code should generate different output each time it runs (use `thisThread.randSeed` with a system-clock seed, or `Date.seed`)
3. **At least 2 distinct sonic materials**: e.g., pitched tones and noise bursts, or voice-like formants and silence
4. **1–3 minute duration**

## Deliverables

1. **`.scd` or `.rb` file**
2. **Audio recording** (1–3 min)
3. **Short write-up** (150–200 words):
   - State the rule you implemented (quote it if using Option A)
   - How faithful is your implementation to the rule? Where did you make interpretive choices?
   - What does this piece have in common with Markov chains or other algorithmic methods covered this week? Where does it differ?

## Grading

| Category | Points |
|----------|--------|
| Rule implementation (follows the stated rule) | 10 |
| Indeterminacy (different on each run) | 5 |
| Sonic materials (at least 2 distinct) | 5 |
| Write-up (rule stated; honest reflection on faithfulness) | 10 |
| **Total** | **30** |

## Context

Cage's *Song Books* was conceived as a kind of open library: each performer (or ensemble) selects solos and performs them in any order and any combination. The solos don't need to form a whole — coexistence is the structure. This is a different relationship between rule and result than Reich's process music (same rule, determinate unfolding) or a Markov chain (same training data, stochastic unfolding). Cage's indeterminacy breaks the composer's control at the level of the rule itself.

**Further reading/listening**: Cage, *Silence: Lectures and Writings* (1961); *A Year from Monday* (1967). The *Song Books* recording with Meerce Cunningham Dance Company (1970) is available at various archives.
