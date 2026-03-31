# =====================================================================
# Ambient Loops — Brian Eno's Discreet Music in Sonic Pi
# =====================================================================
# Music and AI — Week 2
#
# Brian Eno's approach to ambient music (1975):
# "I wanted to make a piece that could be listened to and yet
# could be ignored... like the color of light."
#
# Key technique: Two melodic loops of different lengths play
# simultaneously. Because they cycle at different rates, they
# continuously create new combinations. With long reverb and
# delay, the notes blur into an evolving ambient wash.
#
# This is "process music" — the composer sets up a system and
# lets it unfold. The music writes itself.

use_bpm 60

# --- Loop melodies ---
# Loop 1: 12 events (notes + rests), total duration = 32 beats
p1 = (ring :Db4, :Eb4, :rest, :F3, :rest, :Ab3, :rest, :F4, :Ab4, :Bb4, :Ab4, :rest)
r1 = (ring 1, 3, 4, 4, 4, 4, 4, 1, 1, 1, 2, 3)

# Loop 2: 10 events, total duration = 32 beats (before tempo scaling)
# Different length creates phase drift (ratio ~ 63.5/68.7)
p2 = (ring :Eb4, :F4, :rest, :C4, :Ab3, :rest, :Eb3, :rest, :Ab3, :rest)
r2 = (ring 2, 3, 3, 1, 3, 4, 4, 4, 4, 4)

# --- Shared effects: reverb + long echo ---
with_fx :reverb, room: 0.95, mix: 0.8, damp: 0.9 do
  with_fx :echo, max_phase: 10, phase: 10, decay: 60 do

    # --- Loop 1: 12 notes, steady tempo ---
    # Sine + slight overtone for warmth (like SC's ambientTone SynthDef)
    live_loop :loop1 do
      use_synth :dsaw
      play p1.tick,
        pan: -0.7,
        amp: 0.15,
        attack: 1,
        sustain: 0,
        release: 8,
        cutoff: 85
      sleep r1.look
    end

    # --- Loop 2: 10 notes, slightly different tempo ---
    # use_bpm_mul scales this loop's tempo relative to the global BPM.
    # Ratio 63.5/68.7 means loop2 runs ~7.6% slower, so the two loops
    # continuously drift against each other.
    live_loop :loop2 do
      use_synth :dpulse
      use_bpm_mul 63.5 / 68.7
      play p2.tick,
        pan: 0.7,
        amp: 0.15,
        attack: 1,
        sustain: 0,
        release: 8,
        cutoff: 85
      sleep r2.look
    end

  end
end

# Let this run for several minutes — the two loops
# continuously drift against each other, creating new harmonies.


# --- Music for Airports style ---
# Even simpler: single notes with very long tails, random timing.
# Uncomment below (and comment out the block above) to try this version.

comment do
  use_bpm 60

  airports_notes = (ring 56, 58, 60, 63, 65, 68, 70, 72, 75)

  with_fx :reverb, room: 0.95, mix: 0.8, damp: 0.9 do
    live_loop :airports do
      use_synth :sine
      play airports_notes.choose,
        amp: rrand(0.05, 0.15),
        pan: rrand(-1.0, 1.0),
        attack: rrand(2.0, 5.0),
        sustain: 0,
        release: rrand(8.0, 15.0)
      sleep rrand(3.0, 12.0)
    end
  end
end


# --- Experiment ---
# 1. Change the loop ratio — try irrational numbers (e.g., use_bpm_mul 1.0/1.156)
# 2. Add a third loop with yet another length and a different use_bpm_mul
# 3. Try different scales/modes for different moods (Dorian, Lydian, pentatonic)
# 4. Replace :dsaw/:dpulse with :hollow or :dark_ambience for different timbres
# 5. Adjust echo phase: and decay: — longer decay = more ambient wash
