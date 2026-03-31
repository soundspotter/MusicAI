# Week 8: Ethics, Recommenders & Cultural Implications

## Learning Goals

- Analyze ethical and legal issues surrounding AI-generated music (copyright, training data, ownership)
- Understand music recommender systems (collaborative filtering, content-based, CLAP embeddings)
- Engage with cultural perspectives on AI and music — George Lewis' Voyager as a counterpoint to commercial AI models
- Form and defend informed positions on copyright, ownership, and attribution
- Discuss labor displacement and what the musician's role is in an AI-mediated music industry

## Tuesday — Copyright, Ownership & Debate

**10:10–11:00**

| Time | Activity |
|------|----------|
| 10:10 | **Lecture**: Copyright and AI music — current legal landscape; pending legislation; the training data problem; recent cases (RIAA vs. Suno/Udio, Getty vs. Stability AI) |
| 10:30 | **Activity 8a — Ownership Debate**: 4 groups, 4 positions — (1) the human artist whose music was in the training data; (2) the company that built and trained the model; (3) the user who wrote the prompt and curated the result; (4) the public / no one can own AI-generated music. 3 min prep, 2 min position statement per group, 10 min open debate (see `activity_8a_ownership_debate.md`) |

**Break (11:00–11:10)**

**11:10–12:00**

| Time | Activity |
|------|----------|
| 11:10 | Full-class debrief + straw poll: students may now vote outside their assigned position; tally results; discuss what legal frameworks already exist that might apply and what new frameworks might be needed |
| 11:30 | **Lecture**: Recommender systems — collaborative filtering, content-based filtering, hybrid systems; how music discovery shapes what gets created (filter bubbles, popularity bias) |
| 11:50 | Preview of Thursday's CLAP demo; assign listening: George Lewis *Voyager* excerpts |

## Thursday — Voyager, Recommenders & Labor

**10:10–11:00**

| Time | Activity |
|------|----------|
| 10:10 | **Guided listening — George Lewis' Voyager**: hear two excerpts; guided response questions: how does the system respond to the human performer? What "decisions" is it making? Is this composition, improvisation, or something else? Write answers before discussion. |
| 10:40 | Full-class discussion: Lewis as composer, programmer, musician — how does Voyager differ from MusicGen or YuE? What does that difference reveal about intention, agency, and musical dialogue? |

**Break (11:00–11:10)**

**11:10–12:00**

| Time | Activity |
|------|----------|
| 11:10 | **Demo**: simple collaborative filtering recommender in Colab (`recommender_demo.ipynb`) |
| 11:25 | **Demo**: CLAP embeddings for music similarity (`music_similarity.ipynb`) — audio-text retrieval, neighborhood visualization |
| 11:40 | Discussion: labor displacement — who is harmed and who benefits from AI production tools? What is the musician's role in an AI-mediated industry? Is there a meaningful distinction between "AI as tool" and "AI as replacement"? |

## Code Examples

- `music_similarity.ipynb` — CLAP embeddings for audio-text similarity
- `recommender_demo.ipynb` — Simple collaborative filtering
- `ai_mastering_compare.md` — Comparison of AI mastering tools

## Discussion Questions

1. If an AI model is trained on copyrighted music, who owns the output?
2. Should AI-generated music be labeled as such? Should there be mandatory disclosure?
3. How do recommender systems shape what music gets created? (Filter bubbles, popularity bias)
4. George Lewis built Voyager in 1993 — how does early AI music differ from today's models? What does that difference reveal about intent and design philosophy?
5. Will AI replace session musicians, producers, mixing engineers? Should it?

## Readings

- Recent copyright rulings on AI music (instructor will provide current articles)
- George Lewis, "Too Many Notes: Computers, Complexity and Culture in Voyager" (*Leonardo Music Journal*, 2000)

## Listening

- George Lewis — *Voyager* (1993), two excerpts for guided listening
- Examples from LANDR, iZotope AI mastering (before/after comparison)
- AI-generated music that sparked copyright disputes (instructor curated)
