# Week 9: Final Project Workshop

## Learning Goals

- Make significant progress on final projects
- Give and receive structured peer feedback
- Debug technical issues with instructor support
- Refine project scope and presentation plan

## Tuesday — Working Session & Peer Feedback Round 1

**10:10–11:00**

| Time | Activity |
|------|----------|
| 10:10 | Check-in: each person states current status in one sentence (what you have, what you need) |
| 10:15 | **Working session 1**: individual or pair work; instructor circulates for technical help |

**Break (11:00–11:10)**

**11:10–12:00**

| Time | Activity |
|------|----------|
| 11:10 | **Peer feedback round 1**: groups of 3–4; each person gives a 3-minute demo or preview; group gives structured feedback (5 min per person); rotate until everyone has received feedback |

### Peer Feedback Guidelines

When giving feedback, address:
1. **Concept**: Is the project idea clear and compelling?
2. **Execution**: Does the technical implementation work? What is fragile?
3. **Presentation**: Can you follow the demo? What needs more explanation?
4. **Suggestion**: One specific thing that would improve the project

When receiving feedback:
- Take notes — you will not remember everything
- Ask clarifying questions
- You do not have to implement every suggestion, but consider each one

## Thursday — Working Session & Peer Feedback Round 2

**10:10–11:00**

| Time | Activity |
|------|----------|
| 10:10 | **Working session 2**: continue development; instructor available for technical help, debugging, GPU issues |

**Break (11:00–11:10)**

**11:10–12:00**

| Time | Activity |
|------|----------|
| 11:10 | **Peer feedback round 2**: new groups (different from round 1); same format — 3-min demo, 5-min feedback per person |
| 11:40 | Logistics: presentation schedule (sign-up sheet), submission format, final reminders |

## Technical Support Topics

Common issues at this stage:
- **Colab GPU timeouts**: save checkpoints frequently; use smaller models; mount Drive
- **SuperCollider crashes**: check for infinite loops, runaway synths (Cmd+.)
- **MIDI file issues**: verify with `pretty_midi`; check for zero-length notes
- **Audio quality**: sample rate mismatches, clipping, normalization
- **Git/submission**: how to submit notebooks with outputs, audio files

## Final Project Reminders

**Due Week 10 (day of presentation):**
1. Code (`.scd`, `.ipynb`, `.py`) — well-commented, runnable
2. Audio/video output — demonstrating your results
3. Written report (3–5 pages) — description, methods, results, reflection
4. Presentation slides (10 minutes + 5 min Q&A)

**Submission format:**
- Upload to Canvas as a ZIP file or link to GitHub repository
- Include a README with setup instructions
- Audio files: WAV or MP3, clearly named
