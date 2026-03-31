# Final Project Ideas — Music and AI

Choose one of these project types, or propose your own.

## Creative Projects

### 1. AI-Assisted Album
Create a 3-5 track EP using AI tools from the course. Each track should use a different technique (Markov chains, MusicGen, transformer, etc.). Write liner notes discussing your creative process and the role AI played.

### 2. Live Performance System
Build a SuperCollider performance system that incorporates AI elements: Markov-generated melodies, constrained counterpoint, or the Claude OSC bridge for real-time AI interaction. Perform a 5-10 minute piece.

### 3. Generative Installation
Design a generative music installation that runs indefinitely, creating unique music in real time. Could use SuperCollider with algorithmic composition, or Python with a neural model. Include a plan for how it would be exhibited.

### 4. AI Remix / Mashup
Use Demucs source separation + MusicGen to create a creative remix that would be impossible without AI. Separate stems from existing tracks, recombine with AI-generated elements, and produce a polished result.

### 5. Lyrics-to-Song Concept Album
Write lyrics for 3-5 songs around a theme. Generate each with YuE/Suno/Udio, then compare and select the best versions. Produce a "concept album" with accompanying critical notes on AI's interpretation of your lyrics.

## Technical Projects

### 6. Custom Music Transformer
Train a small transformer on a specific genre or style (jazz, baroque, video game music). Evaluate how well it captures the style. Compare with a Markov model trained on the same data.

### 7. Music Genre Classifier
Build a genre/mood classifier that works on a real dataset (GTZAN, FMA, or your own collection). Experiment with different features and architectures. Achieve and document the best accuracy you can.

### 8. Intelligent Accompaniment System
Build a system that listens to MIDI input and generates real-time accompaniment. Could use Markov chains, a transformer, or rule-based harmony. Test with live performance.

### 9. Music Recommendation Engine
Build a content-based music recommender using CLAP embeddings or audio features. Create a web interface or CLI that takes a song and returns similar tracks. Evaluate against user preferences.

### 10. Style Transfer Tool
Build a tool that takes a melody and re-renders it in a different style using MusicGen melody conditioning. Create a pipeline: input MIDI → synthesize audio → MusicGen with style prompt → output. Compare multiple style transfers of the same source.

## Research Projects

### 11. Perceptual Evaluation of AI Music
Design and conduct a listening study: Can people distinguish AI-generated music from human-composed music? Test with classmates or online participants. Report statistical results.

### 12. Information Content Analysis
Apply IDyOM-style information content analysis to a corpus of music. Compare IC profiles across genres, composers, or historical periods. What makes some music more "surprising" than others?

### 13. Bias in Music Recommenders
Investigate popularity bias, genre bias, or cultural bias in a music recommendation system. Use the CLAP similarity or collaborative filtering from class. Propose and test a debiasing method.

### 14. Copyright and AI Music: Legal Analysis
Research the current legal landscape of AI-generated music copyright. Analyze 3-5 recent cases or rulings. Propose a framework for attribution and ownership. Include legal and technical perspectives.

### 15. Comparing Music Generation Paradigms
Systematically compare 3+ music generation approaches (Markov, LSTM, Transformer, MusicGen, Diffusion) on the same task. Define evaluation criteria (musical, technical, perceptual). Write a comparative analysis.

## Hybrid Projects

### 16. Human-AI Collaborative Composition
Compose a piece where you alternate between human and AI contributions. Document each step: what you wrote, what the AI contributed, what you kept/rejected. Reflect on the collaborative process.

### 17. Sonification of Non-Musical Data
Take a non-musical dataset (weather, stock prices, brain signals, COVID data) and create a musical sonification using techniques from the course. Make it both scientifically meaningful and aesthetically interesting.

### 18. Educational Music AI Tool
Build a tool that teaches a musical concept using AI. Examples: an interactive Markov chain visualizer, a "guess the AI" listening game, or a tool that shows how transformers attend to musical structure.

## Project Scope Guidelines

- **Individual projects**: Pick one idea and execute it well
- **Pair projects**: Combine two ideas or go deeper on one (proportionally more scope expected)
- **Time budget**: Expect to spend 15-20 hours total (weeks 6-10)
- **When in doubt**: Start simple, add complexity if time allows. A polished simple project beats an ambitious unfinished one.

## Deliverables Checklist

- [ ] Working code (well-commented, runnable)
- [ ] Audio/video output demonstrating results
- [ ] Written report (3-5 pages): motivation, methods, results, reflection
- [ ] 10-minute presentation with live demo or audio examples
