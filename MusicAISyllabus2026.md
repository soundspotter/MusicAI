# Music and AI — Spring 2026

**MUS 14.05 / COSC 89.29 / COSC 189.3**
Dartmouth College — Spring 2026 (10-week quarter)

## Course Description

This course explores the intersection of music, computation, and artificial intelligence from the medieval period to the present day. Students engage with both the historical foundations of algorithmic composition — isorhythm, process music, Markov chains, constrained search — and the latest AI music generation systems including large language models, music transformers, and audio diffusion models. The course maintains a 50/50 balance between foundational/historical content and modern AI approaches.

The first three weeks use **SuperCollider** (sclang `.scd`) or **Sonic Pi** (Ruby `.rb`) for real-time synthesis and algorithmic composition — students may choose either environment. Weeks 4–8 shift to **Python** (Google Colab) for machine learning and modern generative models. The final two weeks are devoted to final project development and presentations.

No prior music theory or machine learning experience is required, though familiarity with at least one programming language is expected.

## Instructor

Michael Casey
Department of Music / Department of Computer Science
Dartmouth College

## Schedule

Class meets **Tuesday and Thursday, 10:10 am–12:00 pm** (110 min with a 10-min break).

| Week | Tuesday | Thursday | Tools |
|------|---------|----------|-------|
| 1 | History, Creativity & Deconstruction | Code, Euclidean Rhythms & Breakbeats | SC or Sonic Pi |
| 2 | Sound Design & Synthesis | Process Music & Algorithmic Practice | SC or Sonic Pi |
| 3 | Representation, Markov Chains & Cage | Information Content, Sampling & Synthwave | SC or Sonic Pi |
| 4 | Features & What Machines Hear | Classification & Tokenization | Python / Colab |
| 5 | From Markov to Transformers | Midterm Critique & Evaluation | Python / Colab |
| 6 | Text-to-Music & Prompting | Source Separation, Remix & Diffusion | Python / Colab |
| 7 | Full-Song Generation | LLM Music Coding & Live AI Performance | Python / Colab + SC |
| 8 | Copyright, Ownership & Debate | Voyager, Recommenders & Labor | Python / Colab |
| 9 | Working Session & Peer Feedback Round 1 | Working Session & Peer Feedback Round 2 | Open |
| 10 | Presentations, Session 1 | Presentations, Session 2 & Course Wrap-Up | — |

## Learning Goals

By the end of this course, students will be able to:

1. **Describe** the history of algorithmic composition from isorhythm through AI-generated music
2. **Implement** algorithmic composition techniques (Markov chains, constrained search, process music) in SuperCollider or Sonic Pi
3. **Explain** core ML concepts (features, classification, sequence models, transformers, diffusion) as applied to music
4. **Use** modern AI music tools (MusicGen, music transformers, source separation, lyrics-to-song models) critically and creatively
5. **Evaluate** AI-generated music for quality, originality, and aesthetic value
6. **Discuss** ethical, legal, and cultural implications of AI in music creation and distribution
7. **Complete** an original final project that combines computational methods with musical creativity

## Software & Tools

### SuperCollider or Sonic Pi (Weeks 1–3)
Assignments in Weeks 1–3 can be completed in either **SuperCollider** (sclang `.scd`) or **Sonic Pi** (Ruby `.rb`). All code examples are provided in both languages.

- **SuperCollider**: Download from [supercollider.github.io](https://supercollider.github.io). The course provides a modular performance system (`scwork/system/`) with ready-to-use SynthDefs, pattern templates, and MIDI/CV output support. Optional: sc3-plugins (for DWGPlucked, SVF UGens)
- **Sonic Pi**: Download from [sonic-pi.net](https://sonic-pi.net). A beginner-friendly live coding environment with built-in synths, samples, and effects. No additional plugins required

### Python / Google Colab (Weeks 4–8)
- All notebooks run on **Google Colab free tier** (T4 GPU, ~15GB RAM)
- No local Python installation required
- Key libraries: librosa, scikit-learn, transformers, audiocraft, miditok, demucs, basic-pitch

### Additional Tools
- A MIDI controller is helpful but not required
- Headphones recommended for in-class listening

## Assessment

| Component | Weight | Description |
|-----------|--------|-------------|
| Weekly Assignments (6) | 40% | Weeks 1–6, mix of code + short written reflection |
| Class Participation | 10% | In-class discussion, listening responses, peer feedback |
| Midterm Critique | 10% | Week 5: written evaluation of AI-generated vs. human-composed music |
| Final Project Proposal | 5% | Due Week 5: 1-page proposal |
| Final Project | 25% | Due Week 10: original creative or research project |
| Final Presentation | 10% | Week 10: 10-minute presentation + demo |

### Assignment Policies

- Assignments are due at **11:59 PM** on the specified due date
- Late submissions: 10% penalty per day, up to 3 days late; no credit after 3 days
- One automatic 48-hour extension available (no questions asked) — email instructor before the deadline
- Collaboration: You may discuss approaches with classmates, but all submitted code and writing must be your own. Cite any AI tools used (ChatGPT, Claude, Copilot, etc.) and describe how you used them

### Final Project

The final project is an original work that combines computational/AI methods with music. Projects may be:

- **Creative**: An original composition or installation using techniques from the course
- **Technical**: A software tool, model, or system for music generation or analysis
- **Research**: An empirical study or critical analysis of AI music systems
- **Hybrid**: A combination of creative and technical work

Projects may be individual or in pairs (with proportionally greater scope for pairs). See `Week09/project_ideas.md` for suggested topics.

**Deliverables:**
1. Project proposal (Week 5) — 1 page
2. Final submission (Week 10) — code, audio/video output, and 3–5 page written report
3. In-class presentation (Week 10) — 10 minutes + Q&A

## Weekly Schedule (Detailed)

### Week 1: Algorithmic Music Past & Present
- **Tuesday**: Course intro; lecture on history of algorithmic composition (isorhythm → Mozart → ILLIAC → Eno); Lovelace/Turing discussion; **Activity 1a: Acapella Deconstruction** (groups deconstruct a multitrack recording into algorithmic layers)
- **Thursday**: Live demos — isorhythm, Mozart dice, Euclidean rhythms in SC/Sonic Pi; hands-on coding; **breakbeat listening activity** (pairs sketch rhythmic patterns); Assignment 1b overview
- **Readings**: Simoni Ch. 2 "History of Algorithmic Composition"; Natale & Henrickson "The Lovelace Effect" (2023)
- **Assignment 1 due end of week**: Algorithmic composition (SC or Sonic Pi) using isorhythm or Euclidean rhythms

### Week 2: Synthesis & Process Music
- **Tuesday**: Lecture on subtractive synthesis with live demos; **group sound-matching challenge** (design a patch to match a target timbre); granular synthesis lecture; preview Reich reading
- **Thursday**: Guided close listening (Piano Phase, Discreet Music, In C); full-class discussion on musical process vs. algorithm; SC/Sonic Pi demos; **Activity 2a in-class start** (students begin process music implementation); introduce Assignment 2b (Algorithmic Drummer)
- **Readings**: Steve Reich, "Music as a Gradual Process" (1968); Eno, liner notes to *Discreet Music* (1975)
- **Assignment 2 due end of week**: 3–5 minute ambient/process piece in SC or Sonic Pi

### Week 3: Markov Models & Information Content
- **Tuesday**: Lecture on MIDI/OSC and music representation; Markov chain theory + live demo (orders 1–3); hands-on Markov training; group listening comparison; **Activity 3a in-class** (Cage Song Books rules, small groups)
- **Thursday**: Lecture on information content (IDyOM); **IC group activity** (predict high/low IC in a melody, then compare to computed plot); **synthwave listening + analysis** (map structure and layers); Assignment 3b (Synthwave) overview
- **Readings**: Bown Ch. 3 "Generative Algorithms"; Pearce & Wiggins, "Auditory Expectation" (2012)
- **Assignment 3 due end of week**: Nth-order Markov melody generator with information content analysis (SC or Sonic Pi)

### Week 4: Machine Learning Foundations for Music
- **Tuesday**: Lecture on MIR pipeline; librosa demo; **Activity 4a: Feature Listening Challenge** (describe clips musically, then compare to feature plots); hands-on feature extractor in Colab
- **Thursday**: Classification lecture (SVM, CNN intuitions); genre classifier demo; **group classification game** (hear clips, write genre + confidence, compare to classifier); MidiTok demo; **group tokenization activity** (manually tokenize an 8-bar melody in REMI)
- **Readings**: Casey et al., "Content-Based Music Information Retrieval" (Proc. IEEE, 2008)
- **Assignment 4 due end of week**: Music genre/mood classifier on a small dataset

### Week 5: Sequence Models & Music Transformers
- **Tuesday**: Lecture on Markov → RNN → LSTM; LSTM melody generator demo; group listening comparison (Markov vs. LSTM); lecture on transformers and Music Transformer; AMT demo; discussion on long-term structure
- **Thursday**: **Activity 5a: AI vs. Human Listening Critique** (pairs evaluate 6 unlabeled excerpts on 4 criteria and guess AI vs. human); full-class debrief; SkyTNT demo; Assignment 5 + Final Project Proposal introduced; open brainstorming
- **Readings**: Huang & Eck, "Music Transformer" (2018); Thickstun et al., "Anticipatory Music Transformer" (2023)
- **Assignment 5 due end of week**: Generate and critique 3 pieces; **Final Project Proposal due**

### Week 6: Audio Generation & Diffusion Models
- **Tuesday**: Lecture on audio tokenization; MusicGen demo; **Activity 6a: Prompt Battle** (groups compete to best achieve a shared brief using text prompts); MusicGen melody conditioning demo; breakbeat-to-MusicGen comparison
- **Thursday**: HTDemucs source separation demo; **Activity 6b: Stem Remix** (groups rearrange pre-separated stems into a 30-second remix); group playback and one-word responses; Riffusion demo; ethics discussion on stem separation; Assignment 6 overview
- **Readings**: Copet et al., "Simple and Controllable Music Generation" (2023); Défossez et al., "Hybrid Transformers for Music Source Separation" (2023)
- **Assignment 6 due end of week**: Creative project using MusicGen + Demucs: generate, separate, remix, critique

### Week 7: Voice, Lyrics-to-Song & LLM+Music
- **Tuesday**: Lecture on full-song generation landscape; YuE demo; **group song structure analysis** (compare YuE-generated vs. human track); group lyric-writing and YuE generation; discussion on lyrics and meaning in AI music
- **Thursday**: Lecture on LLMs as music code generators; Claude/GPT code demo; **hands-on prompting** (students generate and fix an SC/Sonic Pi pattern); **Claude OSC bridge live coding** (class collectively directs AI composition in real time); Strudel demo; discussion on live coding and creativity
- **Readings**: Wang et al., "YuE: Open Foundation Model for Music Generation" (2025)

### Week 8: Ethics, Recommenders & Cultural Implications
- **Tuesday**: Lecture on copyright and AI music legal landscape; **Activity 8a: Ownership Debate** (4 groups argue 4 positions); full-class debrief and straw poll; lecture on recommender systems
- **Thursday**: **Guided listening — George Lewis' Voyager** (written response questions, then discussion); recommender systems demo in Colab; CLAP embeddings demo; discussion on labor displacement
- **Readings**: George Lewis, "Too Many Notes: Computers, Complexity and Culture in Voyager" (*Leonardo Music Journal*, 2000); recent copyright rulings on AI music (instructor provided)

### Week 9: Final Project Workshop
- **Tuesday**: Check-in (one sentence per person); working session 1 (individual/pair work); **peer feedback round 1** (groups of 3–4; 3-min demo + 5-min feedback)
- **Thursday**: Working session 2 (technical help from instructor); **peer feedback round 2** (new groups, same format); logistics — presentation schedule, submission format, reminders

### Week 10: Final Project Presentations
- **Tuesday**: Student presentations, Sessions 1 & 2 (10 min + 5 min Q&A each; lead with audio/demo)
- **Thursday**: Student presentations, Sessions 3 & 4; course retrospective discussion; course evaluations
- Written reports and code due day of presentation

## Academic Honor Principle

Students are expected to follow Dartmouth's Academic Honor Principle. For this course:

- **Code**: You may use AI coding assistants (GitHub Copilot, Claude, ChatGPT) but must cite them and describe their contribution. You must understand all code you submit.
- **Writing**: AI-generated text must be clearly marked. Your analysis and critique must be your own.
- **Collaboration**: Discuss freely, but write and code independently unless working on an approved pair project.

## Accessibility

Students with disabilities who may need accommodations should contact the Student Accessibility Services office and the instructor as early as possible.

## Resources

- **SuperCollider**: [supercollider.github.io](https://supercollider.github.io) — IDE, documentation, tutorials
- **Google Colab**: [colab.research.google.com](https://colab.research.google.com) — free GPU notebooks
- **Course code repository**: Provided via Canvas/GitHub
- **Office hours**: TBD
