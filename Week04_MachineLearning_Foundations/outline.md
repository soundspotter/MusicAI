# Week 4: Machine Learning Foundations for Music

## Learning Goals

- Extract audio features (MFCCs, chroma, mel spectrograms) using librosa
- Build a simple music genre/mood classifier in Python (Google Colab)
- Understand music tokenization for ML (MidiTok: REMI, TSD, Structured)
- Recognize what features capture vs. what they miss about musical experience
- Transition conceptually from rule-based algorithmic composition (Weeks 1–3) to data-driven learning

## Tuesday — Features & What Machines Hear

**10:10–11:00**

| Time | Activity |
|------|----------|
| 10:10 | **Lecture**: Transition from rules to learning — the MIR pipeline; what audio features are and why we need them |
| 10:20 | **Demo**: librosa — MFCCs, chroma, mel spectrogram extracted from several tracks; visualize and interpret each |
| 10:40 | **Activity 4a — Feature Listening Challenge**: groups hear 6 audio clips and describe each musically (mood, genre, instruments, energy level, tempo feel) *before* seeing any feature plots; then view MFCC/chroma/mel for each; discuss what the features captured and what they missed (see `activity_4a_feature_listening.md`) |

**Break (11:00–11:10)**

**11:10–12:00**

| Time | Activity |
|------|----------|
| 11:10 | **Hands-on (Colab)**: build a feature extractor — load audio, compute MFCCs, chroma, and spectral centroid; save to a feature matrix; instructor-led walkthrough |
| 11:40 | Full-class discussion: what do features miss about music? What musical dimensions (timbre, harmony, rhythm, form, emotion) are well-served by MFCCs vs. chroma vs. spectrograms? What is irreducibly human in our descriptions? |

## Thursday — Classification & Tokenization

**10:10–11:00**

| Time | Activity |
|------|----------|
| 10:10 | **Lecture**: Classification basics — SVM and CNN intuitions (no math derivation); train/test split; accuracy, confusion matrix |
| 10:20 | **Demo**: genre/mood classifier in Colab — train on a small labeled dataset; visualize confusion matrix |
| 10:35 | **Group classification game**: hear 8 clips; each person writes genre + confidence level (1–5); compare to classifier output; discuss systematic disagreements between human and machine |

**Break (11:00–11:10)**

**11:10–12:00**

| Time | Activity |
|------|----------|
| 11:10 | **Demo**: MidiTok tokenization — REMI, TSD, and Structured token schemes; compare token sequences for the same melody |
| 11:25 | **Group tokenization activity**: manually tokenize a short 8-bar melody fragment using REMI notation on paper; compare your result to MidiTok's actual output; discuss discrepancies |
| 11:45 | Assignment 4 overview + Q&A |

## Readings

- Casey, M. A., Veltkamp, R., Goto, M., Leman, M., Rhodes, C., & Slaney, M. (2008). Content-Based Music Information Retrieval: Current Directions and Future Challenges. *Proceedings of the IEEE*, 96(4), 668–696.

## Discussion Questions

- What do audio features capture about music? What do they miss?
- How does the choice of feature representation shape what a classifier can learn?
- In what ways does the transition from hand-crafted rules (Weeks 1–3) to learned features change how we think about modeling music?
- What musical dimensions (timbre, harmony, rhythm, form) are well-served by MFCCs vs. chroma vs. spectrograms?
- Tokenization converts continuous audio or MIDI into discrete symbols. What is lost or changed in that conversion?
