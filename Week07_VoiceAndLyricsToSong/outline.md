# Week 7: Voice, Lyrics-to-Song & LLM+Music

## Learning Goals

- Understand neural audio codecs and their role in music generation (EnCodec, DAC, SoundStream)
- Use lyrics-to-song models (YuE) for full song generation in Colab
- Use LLMs (Claude, GPT) to generate music code in SuperCollider and Python
- Understand AI-assisted live coding via OSC bridge
- Evaluate commercial vs. open-source full-song AI tools critically

## Tuesday — Full-Song Generation

**10:10–11:00**

| Time | Activity |
|------|----------|
| 10:10 | **Lecture**: Full-song generation landscape — YuE, Suno, Udio, ACE-Step; dual-transformer architectures; text-audio alignment; what "full song" means technically and aesthetically |
| 10:20 | **Demo**: YuE lyrics-to-song generation in Colab (`yue_demo.ipynb`) — generate two tracks from different lyric/style prompts |
| 10:40 | **Group song structure analysis**: analyze a YuE-generated track and a human-written track of the same genre — in groups, map: intro/verse/chorus/bridge/outro timings; how transitions are handled; what changes between sections; where each track succeeds or fails structurally |

**Break (11:00–11:10)**

**11:10–12:00**

| Time | Activity |
|------|----------|
| 11:10 | **Group activity**: each group writes 4 lines of simple lyrics for a pop structure (verse or chorus); generates a song with YuE; evaluates the result musically — does it serve the lyrics? Does it have a hook? |
| 11:35 | Discussion: lyrics, meaning, and AI — what is lost when a machine "writes" a song? What is the relationship between language and music in pop? Can AI understand what a lyric is about? |

## Thursday — LLM Music Coding & Live AI Performance

**10:10–11:00**

| Time | Activity |
|------|----------|
| 10:10 | **Lecture**: LLMs as music code generators — what they can and can't do; hallucination, style, idiomatic SC/Python code |
| 10:20 | **Demo**: Claude/GPT writing SC patterns and Python MIDI code (`llm_music_code.ipynb`) — several examples, including a broken one to debug |
| 10:40 | **Hands-on**: students prompt Claude to generate a short SC or Sonic Pi pattern for a specific musical goal (e.g., "a polyrhythmic ostinato in 7/8 using a pentatonic scale"); evaluate the output and modify it to fix issues or extend it |

**Break (11:00–11:10)**

**11:10–12:00**

| Time | Activity |
|------|----------|
| 11:10 | **Live class activity — Claude OSC bridge live coding**: instructor at keyboard; class collectively directs the AI to compose in real time by voting on each successive prompt; hear the result evolve |
| 11:40 | **Demo**: Strudel + AI live coding in browser — quick browser-based demo |
| 11:50 | Discussion: is AI-assisted live coding still "live"? Where is the creativity — in the prompt, the output, or the curation? What is the performer's role? |

## Code Examples

- `yue_demo.ipynb` — YuE lyrics-to-song generation
- `llm_music_code.ipynb` — LLM generates SC and Python music code
- `claude_osc_bridge.scd` — OSC bridge for AI live coding
- `strudel_ai.md` — Guide to Strudel + LLM live coding

## Discussion Questions

1. Can AI write a hit song? What would that even mean?
2. What is the role of lyrics in AI-generated music vs. human music? Does meaning matter to the model?
3. Is AI-assisted live coding still "live" performance? Where is the creativity?
4. Should AI-generated songs be eligible for music awards or copyright protection?
5. LLMs sometimes produce syntactically valid but musically incoherent code. What does that reveal about what they understand?

## Readings

- Wang et al., "YuE: Open Foundation Model for Music Generation" (2025)

## Listening

- YuE-generated examples (from the paper and in-class generation)
- Suno/Udio-generated songs (student-selected, brought to class)
