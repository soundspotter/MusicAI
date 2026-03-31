# Strudel + AI — Browser-Based Live Coding

## What is Strudel?

[Strudel](https://strudel.cc) is a browser-based live coding environment for music, inspired by TidalCycles (Haskell). It runs entirely in the browser — no installation required.

**Key features:**
- Pattern-based music notation
- Real-time editing with instant audio feedback
- Built-in synthesizers and sample library
- Works on any device with a browser

## Using AI with Strudel

### Method 1: LLM as Pattern Generator

1. Open [strudel.cc](https://strudel.cc) in your browser
2. In a separate tab, open Claude (claude.ai) or ChatGPT
3. Ask: "Write a Strudel pattern for [description]"
4. Paste the generated code into Strudel
5. Iterate: "make it more complex" → new code → paste

### Example Prompts and Outputs

**Prompt:** "Write a minimal techno beat in Strudel"
```javascript
stack(
  s("bd*4").gain(0.8),
  s("~ sd ~ sd").gain(0.6),
  s("hh*8").gain(0.3),
  s("~ ~ oh ~").gain(0.4)
).cpm(130/4)
```

**Prompt:** "Create an ambient drone piece"
```javascript
stack(
  note("c2 e2".slow(8)).s("sawtooth")
    .cutoff(sine.range(200, 800).slow(16))
    .gain(0.3).room(0.9),
  note(choose("c4","e4","g4","b4"))
    .s("triangle")
    .delay(0.6).delaytime(0.375)
    .gain(0.15).slow(3),
  note("c5 g4 e5 b4".slow(4))
    .s("sine")
    .gain(0.1).room(0.95)
)
```

**Prompt:** "Generate a polyrhythmic pattern with African bell rhythms"
```javascript
stack(
  s("bell*12").euclid(7,12).gain(0.5),
  s("casio:0*8").euclid(5,8).gain(0.4),
  s("bd*4").gain(0.7),
  s("sd:1").euclid(3,8).gain(0.5)
).cpm(110/4)
```

**Prompt:** "Write generative ambient with random note choices"
```javascript
stack(
  note(choose("c3","e3","g3","b3","d4"))
    .s("sawtooth")
    .cutoff(sine.range(300, 1500).slow(8))
    .room(0.8).gain(0.2)
    .slow(choose(2,3,4,5)),
  note(choose("e4","g4","b4","c5"))
    .s("triangle")
    .delay(0.5).room(0.9)
    .gain(0.1).slow(choose(3,5,7))
)
```

### Method 2: Iterative Refinement

The most powerful workflow:

1. **Start simple:** Ask for a basic pattern
2. **Listen:** Evaluate what you hear
3. **Refine:** "Add more syncopation", "Make the bass deeper", "Add a filter sweep"
4. **Layer:** "Add a melody on top", "Include a pad sound"
5. **Structure:** "Make it evolve over 32 bars"

### Tips for Better LLM-Generated Strudel Code

1. **Be specific about genre:** "90s jungle" works better than "electronic music"
2. **Specify instruments:** "kick, snare, hihat, acid bass"
3. **Include musical details:** "120 BPM, 4/4 time, minor key"
4. **Reference patterns:** "Use a tresillo rhythm for the bass"
5. **Ask for comments:** "Add comments explaining each line"

## Discussion Questions

1. How does text → code → music compare to text → audio (MusicGen)?
2. What creative control does code-based generation offer that audio generation doesn't?
3. Is the human's role more like a "composer", "conductor", or "curator"?
4. Could a non-programmer use LLM + Strudel to make interesting music?
