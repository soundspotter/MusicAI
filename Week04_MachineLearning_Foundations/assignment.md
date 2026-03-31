# Assignment 4: Music Genre/Mood Classifier

**Due:** End of Week 4
**Points:** 40

## Task

Build a music classifier using audio features. Choose one of:

- **Genre classification** (e.g., rock vs. classical vs. jazz)
- **Mood classification** (e.g., happy vs. sad vs. energetic)

## Requirements

1. **Feature extraction (10 pts):** Extract at least 3 types of audio features from your audio clips. Choose from: MFCCs, chroma features, spectral centroid, spectral bandwidth, spectral rolloff, zero-crossing rate, tonnetz, or tempo/beat features.

2. **Classification (10 pts):** Implement an SVM or another classifier of your choice (Random Forest, k-NN, simple neural network). Train on your extracted features.

3. **Evaluation (10 pts):** Use k-fold cross-validation with k >= 5. Report:
   - Overall accuracy
   - Per-class precision, recall, and F1-score
   - Confusion matrix (visualized as a heatmap)

4. **Written analysis (10 pts):** Write a 300-word analysis addressing:
   - Which features were most informative and why?
   - What errors did your classifier make? Are they musically understandable?
   - How might you improve the classifier?

## Dataset

- Use at least **10 audio clips per class** (minimum 2 classes).
- You may use clips from the GTZAN dataset, FMA dataset, your own collection, or any other source.
- Audio clips should be at least 10 seconds long.
- Document your data sources.

## Deliverables

1. **Colab notebook (.ipynb)** containing all code, outputs, and visualizations
2. **Written analysis** (300 words, can be included in the notebook as markdown cells)

## Grading Rubric

| Component | Points | Criteria |
|-----------|--------|----------|
| Feature extraction | 10 | Correct extraction of >= 3 feature types, appropriate preprocessing |
| Classification | 10 | Working classifier, proper train/test methodology |
| Evaluation | 10 | Cross-validation, confusion matrix, per-class metrics |
| Analysis | 10 | Thoughtful interpretation of results, musical insight |
| **Total** | **40** | |

## Tips

- Start with the `audio_features.ipynb` and `genre_classifier.ipynb` notebooks from class as templates.
- Normalize your features before classification (StandardScaler).
- Try multiple classifiers and compare results.
- Consider using `librosa.feature.mfcc`, `librosa.feature.chroma_stft`, and `librosa.feature.spectral_centroid` as your three feature types.
