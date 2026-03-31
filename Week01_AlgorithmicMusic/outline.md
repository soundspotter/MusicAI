# Week 1: Algorithmic Music Past & Present

## Learning Goals

- Understand the historical arc of algorithmic composition from medieval isorhythm to modern generative systems
- Distinguish between algorithmic, generative, and AI-based composition approaches
- Implement basic generative techniques in SuperCollider or Sonic Pi using isorhythm and Euclidean rhythms
- Analyze how constrained randomness and combinatorial methods produce musical variety from simple rules
- Engage critically with questions of computational creativity (Lovelace, Turing, and beyond)
- Deconstruct a multitrack musical work into its constituent algorithmic/structural layers

## Tuesday — History, Creativity & Deconstruction

**10:10–11:00**

| Time | Activity |
|------|----------|
| 10:10 | Course introduction and overview; syllabus Q&A |
| 10:20 | **Lecture**: History of algorithmic composition — isorhythm (de Vitry, Machaut) → Mozart's *Würfelspiel* → ILLIAC Suite (Hiller & Isaacson) → Eno's Generative Music 1 |
| 10:45 | **Discussion**: Lovelace/Turing — "can machines originate anything?" Full-class discussion using the four discussion questions below |

**Break (11:00–11:10)**

**11:10–12:00**

| Time | Activity |
|------|----------|
| 11:10 | **Activity 1a — Acapella Deconstruction**: groups of 4–5 receive a multitrack recording and a score/layer sheet; identify each layer's role and describe it as an algorithm or rule (see `activity_1a_acapella_deconstruction.md`) |
| 11:40 | Group performances + debrief: each group presents their deconstruction; connect each layer to an algorithmic concept from the lecture (isorhythm, combinatorics, process, etc.) |

## Thursday — Code, Euclidean Rhythms & Breakbeats

**10:10–11:00**

| Time | Activity |
|------|----------|
| 10:10 | **Live demo**: isorhythm in SC/Sonic Pi (`isorhythm.scd`) — color and talea of different lengths |
| 10:20 | **Live demo**: Mozart dice game (`mozart_dice.scd`) — combinatorial composition |
| 10:30 | **Live demo**: Euclidean rhythms (`euclidean_rhythms.scd`) — Bjorklund algorithm, world music examples |
| 10:40 | **Hands-on**: students modify isorhythm parameters (color length, talea length, scale), add a second voice; instructor circulates |

**Break (11:00–11:10)**

**11:10–12:00**

| Time | Activity |
|------|----------|
| 11:10 | **Breakbeat listening activity**: hear 5–6 breaks from the Assignment 1b list; in pairs, identify the drum voices and sketch the rhythmic pattern on paper |
| 11:30 | Full-class discussion: what makes a break "sampleable"? Discuss rhythm, space, sonic character, and tempo feel |
| 11:50 | Assignment 1 overview + Assignment 1b (Breakbeat Synthesis) overview and Q&A (see `assignment_1b_breakbeat_synthesis.md`) |

## Code Examples to Demo

- `code/isorhythm.scd` — Medieval isorhythmic technique with color and talea
- `code/mozart_dice.scd` — Mozart's Musikalisches Wurfelspiel (dice game)
- `code/euclidean_rhythms.scd` — Bjorklund algorithm, world music rhythms, layered polyrhythms

## Discussion Questions

1. Mozart's dice game can produce over 4.6 × 10^16 unique minuets, yet every one sounds unmistakably like Mozart. Where does the creativity reside — in the system, the pre-composed fragments, or the act of designing the game?
2. Ada Lovelace wrote that the Analytical Engine "has no pretensions to originate anything." Does an isorhythmic motet — where the composer fixes color and talea but not their interaction — originate something new, or merely execute a procedure?
3. At what point (if any) does increasing algorithmic complexity cross a threshold into genuine musical creativity? Is there a qualitative difference between a dice game, a Markov chain, and a neural network?
4. Brian Eno argued that generative music shifts the composer's role from architect of sounds to architect of systems. What is gained and what is lost in this shift?

## Readings

- Simoni, M. (2003). *Algorithmic Composition: A Gentle Introduction Using Music and AI*, Chapter 2: "History of Algorithmic Composition."
- Natale, S. & Henrickson, L. (2023). "The Lovelace Effect: Perceptions of Creativity in Machines." *New Media & Society*, 25(7), 1553–1571.

## Listening

- **Mozart** — *Musikalisches Würfelspiel*, K. 294d/516f (any realization)
- **Brian Eno** — *Generative Music 1* (1996, SSEYO Koan realization)
- **Hiller & Isaacson** — *ILLIAC Suite for String Quartet* (1957), Experiment 1 excerpt
- **Various** — Breakbeat breaks from Assignment 1b list (in-class Thursday)
