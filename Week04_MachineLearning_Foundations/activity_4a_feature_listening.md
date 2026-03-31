# Activity 4a: Feature Listening Challenge

**Week 4 — Tuesday, in class (~20 minutes)**
**Format**: small groups (3–4 students)

---

## Overview

Before you see any math or feature plots, you are going to describe music the way a human would. Then you will see what a machine sees — MFCCs, chroma, and mel spectrograms — and compare the two perspectives. The goal is to build an intuition for what audio features capture and what they miss.

---

## Part 1 — Listening First (10 min)

The instructor will play 6 short audio clips (15–30 seconds each). For each clip, write your answers to these three questions **before** any feature plots are shown.

**Clip 1**

1. Describe the mood or emotional character of this music.
2. What genre, style, or era does it suggest?
3. List the instruments or sound sources you can identify.

**Clip 2**

1. Describe the mood or emotional character of this music.
2. What genre, style, or era does it suggest?
3. List the instruments or sound sources you can identify.

**Clip 3**

1. Describe the mood or emotional character of this music.
2. What genre, style, or era does it suggest?
3. List the instruments or sound sources you can identify.

**Clip 4**

1. Describe the mood or emotional character of this music.
2. What genre, style, or era does it suggest?
3. List the instruments or sound sources you can identify.

**Clip 5**

1. Describe the mood or emotional character of this music.
2. What genre, style, or era does it suggest?
3. List the instruments or sound sources you can identify.

**Clip 6**

1. Describe the mood or emotional character of this music.
2. What genre, style, or era does it suggest?
3. List the instruments or sound sources you can identify.

---

## Part 2 — Feature Reveal (5 min)

The instructor will now show the **MFCC**, **chroma**, and **mel spectrogram** plots for each clip.

For each clip, discuss with your group:

- Which features in the plot correspond to something you heard and described?
- Which aspects of your description have **no visible counterpart** in the feature plots?
- What would a classifier "see" from this plot alone? What information does it have access to, and what is it blind to?

---

## Part 3 — Group Debrief (5 min)

Each group reports one finding to the class:

- One thing the features captured well
- One thing the features missed entirely
- One aspect of music you think would be very hard to encode as a feature

---

## Instructor Notes

**Suggested clip selection** (aim for variety in tempo, texture, timbre, genre, and mood):
- A complex orchestral passage with fast harmonic motion
- A sparse, slow ambient/drone track
- A drum-heavy hip-hop beat (no melody)
- A solo vocal melody (minimal accompaniment)
- An electronic dance track with steady beat and synthesized bass
- A jazz piano trio excerpt with improvisation

**Feature display**: show plots one clip at a time; hold the clip number in the title so students can match their sheet. Use a 30-second window, same parameters across all clips for fair comparison.

**Key teaching points to draw out during debrief**:
- MFCCs capture timbral texture well but discard absolute pitch
- Chroma captures harmonic content but is insensitive to octave and timbre
- Mel spectrogram is the most "complete" but is also hardest to interpret by eye
- None of the features encode: narrative, emotion, cultural context, or intended meaning
- A classifier trained on these features has no concept of "sadness" — only statistical regularities
