# =====================================================================
# Subtractive Synthesis in Sonic Pi
# =====================================================================
# Music and AI — Week 2
#
# Subtractive synthesis starts with harmonically rich waveforms
# (saw, pulse, noise) and shapes them with filters and envelopes.
# This is the basis of Moog, ARP, and most analog synthesizers.
#
# Sonic Pi has built-in synths that model these classic architectures,
# so we don't need to build SynthDefs — just pick a synth and tweak.

# --- Part 1: Oscillator Zoo ---
# Listen to each waveform's harmonic content
# (Evaluate each block one at a time with Run)

# Sawtooth: all harmonics (1, 2, 3, 4, ...) — bright, buzzy
use_synth :saw
play 57, amp: 0.3, sustain: 2, release: 0.5
sleep 3

# Pulse/Square: odd harmonics (1, 3, 5, 7, ...) — hollow
use_synth :square
play 57, amp: 0.3, sustain: 2, release: 0.5
sleep 3

# Sine: fundamental only — pure, clean
use_synth :sine
play 57, amp: 0.3, sustain: 2, release: 0.5
sleep 3

# White noise: all frequencies — used for percussion, texture
use_synth :noise
play 0, amp: 0.2, sustain: 2, release: 0.5
sleep 3


# --- Part 2: Filters ---
# Low-pass filter removes high frequencies (controls brightness)
# In Sonic Pi, `cutoff:` is a MIDI note number (0-130) controlling
# the filter frequency. 60 = middle C (~262 Hz), 130 = very bright.

use_synth :saw
puts "Low cutoff (dark):"
play 57, amp: 0.3, cutoff: 60, sustain: 2, release: 0.5
sleep 3

puts "Mid cutoff:"
play 57, amp: 0.3, cutoff: 90, sustain: 2, release: 0.5
sleep 3

puts "High cutoff (bright):"
play 57, amp: 0.3, cutoff: 120, sustain: 2, release: 0.5
sleep 3


# --- Part 3: Envelopes + Filter ---
# ADSR shapes amplitude over time.
# Sonic Pi synths accept attack:, decay:, sustain_level:, sustain:, release:
# The `cutoff:` parameter acts as a static filter — for filter envelopes
# we can use the :tb303 synth which has a built-in filter envelope.

# Simple subtractive melody using :dsaw (detuned saw — two oscillators)
use_synth :dsaw
use_bpm 120

melody   = (ring 0, 2, 4, 5, 7, 5, 4, 2)
cutoffs  = (ring 80, 90, 100, 90)

live_loop :sub_melody do
  play (scale :c4, :major)[melody.tick],
    amp: 0.3,
    cutoff: cutoffs.look,
    attack: 0.01,
    decay: 0.2,
    sustain_level: 0.7,
    sustain: 0,
    release: 0.5
  sleep 0.5
end


# --- Part 4: The Moog Bass ---
# Sonic Pi's :tb303 synth models classic acid bass with resonant filter
# and filter envelope — the closest built-in to a Moog-style sound.
# :dsaw gives us dual detuned oscillators for thickness.

comment do
  # Stop the melody above first, then run this block
  use_bpm 120

  degrees  = (ring 0, 0, 3, 5, 7, 5, 3, 0)
  durs     = (ring 0.5, 0.25, 0.25, 0.5, 0.5, 0.25, 0.25, 0.5)

  live_loop :moog_bass do
    use_synth :tb303
    d = degrees.tick
    play (scale :c2, :major)[d],
      amp: 0.4,
      cutoff: 70 + (30 * Math.sin(tick(:cutoff_lfo) * 0.05)),  # Sweeping cutoff like Pseg
      res: 0.6,
      attack: 0.01,
      release: 0.3,
      wave: 1  # 0 = saw, 1 = pulse
    sleep durs.look
  end
end


# --- Experiment ---
# 1. Try :tb303 for the melody — adjust cutoff: and res: for acid sounds
# 2. Compare :saw, :dsaw, :square, :dtri for different timbres
# 3. Add with_fx :lpf, cutoff: 80 around a live_loop for external filtering
# 4. Create a pad sound with long attack/release using :dsaw or :dpulse
# 5. Try :prophet synth — Sonic Pi's PWM-style detuned synth
