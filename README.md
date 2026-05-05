# MusicAI

Code examples, activities, and assignments for **CS 89.2 / MUS 14.05 — Music and AI** (Dartmouth College). The course traces a path from medieval algorithmic composition through modern deep learning for music, combining hands-on coding with critical listening and historical context.

## Course Progression

Weeks 1–3 use **Sonic Pi** (`.rb`) and **SuperCollider** (`.scd`) for live, playable code. Weeks 4–8 shift to **Python / Jupyter** (`.ipynb`, run in Google Colab or locally) as the focus moves to machine learning. Each week contains an `outline.md`, one or more `activity_*.md` files for in-class exercises, an `assignment.md`, and a `code/` subdirectory.

---

## Weekly Contents

### Week01 — Algorithmic Music Past & Present
Historical arc from medieval isorhythm to Euclidean rhythms and combinatorial composition. Covers the Lovelace/Turing creativity debate. Code implements isorhythm (talea/color), Euclidean rhythm generation (Bjorklund), and Mozart's *Musikalisches Würfelspiel* (dice game) in both Sonic Pi and SuperCollider.

### Week02 — Synthesis & Process Music
Subtractive, FM, and granular synthesis; process and ambient music (Steve Reich, Brian Eno). Code covers subtractive synth patches, FM synthesis, Reich piano phasing, and generative ambient loops in Sonic Pi and SuperCollider.

### Week03 — Markov Models & Information Content
MIDI/OSC protocols; nth-order Markov chain melody generation; multiple viewpoints; information content (surprisal) via the IDyOM framework (Pearce); constrained voice leading and counterpoint. Code implements first- through nth-order Markov chains, sampling strategies (greedy, temperature, nucleus), multiple-viewpoint models, and voice-leading rules in Sonic Pi and SuperCollider.

### Week04 — Machine Learning Foundations
Transition from rule-based to data-driven composition. Audio feature extraction (MFCCs, chroma, mel spectrograms) with librosa; music genre/mood classification; music tokenization for ML (MidiTok: REMI, TSD, Structured). Python Jupyter notebooks, runs in Colab.

### Week05 — Sequence Models & Transformers
RNN/LSTM architecture and the vanishing gradient problem; self-attention and transformer architecture; symbolic music generation with Music Transformer and Anticipatory Music Transformer (AMT). Notebooks cover LSTM melody training, Music Transformer generation, MidiTok tokenization, and the SkyTNT midi-model demo.

### Week06 — Audio Generation & Diffusion Models
Audio tokenization (EnCodec / residual vector quantization); text-to-music and melody-conditioned generation with MusicGen (AudioCraft); spectral diffusion with Riffusion; 4-stem source separation with HTDemucs. Activities include a prompt-writing competition and a stem-remix exercise.

### Week07 — Voice, Lyrics-to-Song & LLM+Music
Full-song generation landscape (YuE, Suno, Udio); lyrics-to-song with YuE in Colab; LLM-assisted music coding (Claude/GPT → SuperCollider / Python); AI-assisted live coding via Claude OSC bridge (`claude_osc_bridge.scd`); Strudel AI live coding.

### Week08 — Ethics, Recommenders & Cultural Implications
Copyright and training data (RIAA vs. Suno/Udio); music recommender systems (collaborative filtering, CLAP embeddings); cultural critique of commercial AI music (George Lewis's *Voyager* as counterexample); AI mastering tools comparison. In-class ownership debate with four assigned stakeholder positions.

### Week09 — Final Project Workshop
Structured working sessions and two rounds of peer feedback. Includes `project_ideas.md` with suggested directions across research, software, and creative formats.

### Week10 — Final Project Presentations
10-minute demo-first presentations with Q&A. Course retrospective discussion.

---

## Legacy Material — `24S/`

The `24S/` subdirectory contains course materials from Spring 2024, organized as a 5-week arc:

| Directory | Contents |
|---|---|
| `Week1_AlgorithmicMusic_MedievalAndClassical/` | Isorhythm, Euclidean rhythms, Mozart dice game (Sonic Pi); Mozart audio samples |
| `Week2_ProcessMusic_AmbientMusic/` | Reich phasing, Eno ambient (Sonic Pi) |
| `Week3_RuleBasedConstraints_MelodyHarmonyRhythm/` | Four-voice counterpoint, drum patterns, motivic generation (Sonic Pi) |
| `Week4_FiniteStateAutomata_MarkovModels/` | Markov melody generation (Sonic Pi) |
| `Week5_MusicTransformer/` | Magenta.js demos: MusicRNN, MusicVAE, MusicVAE MIDI output, DDSP |

The current (root-level) weekly directories supersede the `24S/` material and expand the course to a full 10-week arc with deeper ML coverage.
