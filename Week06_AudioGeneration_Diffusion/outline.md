# Week 6: Audio Generation & Diffusion Models

## Learning Goals

- Understand audio tokenization (EnCodec, SoundStream, VQ-VAE, residual vector quantization)
- Use MusicGen for text-to-music and melody-conditioned generation
- Understand diffusion models for audio (Riffusion spectral diffusion)
- Use HTDemucs for 4-stem source separation
- Critically evaluate AI-generated audio quality and the ethics of remix

## Tuesday — Text-to-Music & Prompting

**10:10–11:00**

| Time | Activity |
|------|----------|
| 10:10 | **Lecture**: From symbolic to audio generation; audio tokenization — EnCodec, SoundStream, residual vector quantization, codebooks; why discrete representations enable language-model-style generation |
| 10:20 | **Demo**: MusicGen text-to-music generation in Colab (`musicgen_demo.ipynb`) — several contrasting prompts |
| 10:40 | **Activity 6a — Prompt Battle**: groups of 3 each write a text prompt targeting the same brief (e.g., "a melancholy 80s synth ballad with slow tempo, minor key, and reverb-heavy drums"); generate with MusicGen; class hears each result blind and votes on best; then read prompts aloud; discuss what made prompts effective (see `activity_6a_prompt_battle.md`) |

**Break (11:00–11:10)**

**11:10–12:00**

| Time | Activity |
|------|----------|
| 11:10 | **Demo**: MusicGen melody conditioning + style transfer (`musicgen_melody.ipynb`) |
| 11:30 | **Group activity**: describe your Assignment 1b breakbeat in words (tempo, feel, era, style); generate a version with MusicGen; compare the AI audio to your SC/Sonic Pi synthesis; what is similar? what is different? |
| 11:50 | Discussion: text-to-music vs. code-based composition — control, intention, craft. What is the composer's role in each? |

## Thursday — Source Separation, Remix & Diffusion

**10:10–11:00**

| Time | Activity |
|------|----------|
| 10:10 | **Demo**: HTDemucs 4-stem source separation in Colab (`demucs_separation.ipynb`) — run on a supplied track; hear each stem in isolation |
| 10:30 | **Activity 6b — Stem Remix**: groups receive pre-separated stems (drums, bass, other, vocals) from a supplied track; using a browser DAW or GarageBand/Audacity, rearrange, mute, or layer the stems creatively; prepare a 30-second result (see `activity_6b_stem_remix.md`) |

**Break (11:00–11:10)**

**11:10–12:00**

| Time | Activity |
|------|----------|
| 11:10 | Groups play remix results (30 sec each); class responds with one word per remix |
| 11:20 | **Demo**: Riffusion spectral diffusion (`riffusion_demo.ipynb`) — image-space generation, interpolation between styles |
| 11:35 | Discussion: ethical implications of stem separation for existing recordings; the remix economy; when does transformation become appropriation? |
| 11:50 | Assignment 6 overview + Q&A |

## Readings

- Copet et al., "Simple and Controllable Music Generation" (MusicGen, 2023)
- Défossez et al., "Hybrid Transformers for Music Source Separation" (HTDemucs, 2023)

## Discussion Questions

- Text-to-music vs. symbolic generation — which gives more creative control? Which produces more musically interesting results?
- What are the limitations of current audio generation models? What do they struggle with?
- How does operating in spectrogram space (Riffusion) compare to operating in token space (MusicGen)?
- What are the ethical implications of source separation technology for existing recordings?
- If you can separate and recombine stems from any recording, who owns the result?

## Code

- `code/musicgen_demo.ipynb` — MusicGen text-to-music generation
- `code/musicgen_melody.ipynb` — MusicGen melody conditioning and style transfer
- `code/demucs_separation.ipynb` — HTDemucs source separation
- `code/riffusion_demo.ipynb` — Riffusion spectral diffusion
