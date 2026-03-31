# =====================================================================
# Isorhythm -- Color and Talea in Sonic Pi
# =====================================================================
# Music and AI -- Week 1
#
# Isorhythm (c. 1250-1450): A technique where a repeating rhythmic
# pattern (talea) is combined with a repeating pitch pattern (color)
# of a different length. The two cycle independently, creating
# musical variation until they realign.
#
# Example: If color has 5 notes and talea has 4 durations,
# the pattern repeats every 20 notes (LCM of 5 and 4).
#
# Historical context: Philippe de Vitry and Guillaume de Machaut
# used isorhythm extensively in 14th-century motets. The tenor voice
# would carry a cantus firmus with fixed color and talea, while
# upper voices moved more freely.
# =====================================================================


# =============================================
# Part 1: Basic Isorhythm
# =============================================
# Color: repeating pitch sequence (scale degrees mapped to MIDI)
# Talea: repeating rhythm sequence (durations in beats)
#
# We use rings so .tick cycles through each independently.
# Since the rings have different lengths (7 vs 5), the same
# pitch-rhythm combination won't recur until 35 notes (LCM of 7,5).

color = (ring 60, 62, 64, 65, 67, 69, 71)  # 7 pitches (C major scale)
talea = (ring 0.5, 0.25, 0.25, 0.75, 0.25) # 5 durations

puts "Color length: #{color.size}, Talea length: #{talea.size}, Full cycle: 35 notes"

live_loop :isorhythm do
  use_synth :beep
  play color.tick(:color), amp: 0.5, sustain: talea.look(:talea) * 0.8, release: 0.05
  sleep talea.tick(:talea)
end

# Uncomment the stop line and re-run to stop before trying Part 2
# stop


# =============================================
# Part 2: Two-Voice Isorhythm
# =============================================
# Medieval motet style: tenor (slow color/talea) + upper voice
# The tenor carries a cantus firmus in long notes while the
# upper voice (duplum) has its own faster isorhythmic pattern.
#
# Comment out Part 1's live_loop above before running this section.

=begin
use_synth :beep

# Tenor: 5-note color with 4-duration talea -> cycle of 20 notes
tenor_color = (ring 48, 55, 50, 53, 55)           # 5-note color (octave 3)
tenor_talea = (ring 2, 1.5, 1, 2.5)               # 4-duration talea

# Upper voice: 6-note color with 5-duration talea -> cycle of 30 notes
upper_color = (ring 79, 77, 76, 74, 76, 77)       # 6-note color (octave 5)
upper_talea = (ring 0.5, 0.25, 0.25, 0.5, 0.5)    # 5-duration talea

live_loop :iso_tenor do
  play tenor_color.tick(:tc), amp: 0.4, sustain: tenor_talea.look(:tt) * 1.0, release: 0.1
  sleep tenor_talea.tick(:tt)
end

live_loop :iso_upper do
  play upper_color.tick(:uc), amp: 0.3, sustain: upper_talea.look(:ut) * 0.6, release: 0.05
  sleep upper_talea.tick(:ut)
end
=end


# =============================================
# Part 3: Three-Voice Isorhythm with Scale
# =============================================
# Adding a middle voice and using Dorian mode for a medieval flavor.
#
# Comment out Parts 1 and 2 above before running this section.

=begin
use_bpm 100

# Dorian scale degrees mapped to MIDI offsets from root D
# D Dorian: D E F G A B C
dorian = (ring 0, 2, 3, 5, 7, 9, 10)

# Tenor: 4-note color, 3-duration talea (LCM=12)
t_color = (ring 0, 3, 1, 4)
t_talea = (ring 3, 2, 2.5)

# Middle: 5-note color, 4-duration talea (LCM=20)
m_color = (ring 2, 4, 6, 4, 2)
m_talea = (ring 1, 0.5, 0.75, 0.75)

# Upper: 7-note color, 6-duration talea (LCM=42)
u_color = (ring 7, 6, 5, 4, 3, 2, 3)
u_talea = (ring 0.5, 0.25, 0.25, 0.5, 0.25, 0.25)

use_synth :beep

live_loop :tri_tenor do
  deg = t_color.tick(:tc)
  note = 50 + dorian[deg % dorian.size]  # Octave 3 (D3 = 50)
  play note, amp: 0.45, sustain: t_talea.look(:tt) * 1.0, release: 0.1
  sleep t_talea.tick(:tt)
end

live_loop :tri_middle do
  deg = m_color.tick(:mc)
  note = 62 + dorian[deg % dorian.size]  # Octave 4 (D4 = 62)
  play note, amp: 0.3, sustain: m_talea.look(:mt) * 0.7, release: 0.05
  sleep m_talea.tick(:mt)
end

live_loop :tri_upper do
  deg = u_color.tick(:uc)
  note = 74 + dorian[deg % dorian.size]  # Octave 5 (D5 = 74)
  play note, amp: 0.2, sustain: u_talea.look(:ut) * 0.5, release: 0.05
  sleep u_talea.tick(:ut)
end
=end


# --- Experiments ---
#
# 1. Different color/talea lengths:
#    Coprime numbers (e.g., 7 and 5) create the longest cycles
#    before the pattern repeats. Try lengths that share a common
#    factor (e.g., 6 and 4) -- how does this change the feel?
#
# 2. Different scales:
#    Replace the color ring with notes from :phrygian, :minor,
#    or :chromatic scales using scale(:d4, :phrygian)
#
# 3. Add a third or fourth voice with its own color/talea
#
# 4. Vary dynamics with an isorhythmic amplitude pattern:
#    amp_ring = (ring 0.6, 0.3, 0.4, 0.5, 0.3, 0.6, 0.2)
#    play note, amp: amp_ring.tick(:amp)
#
# 5. Change the root pitch over time:
#    transpose = (ring 0, 0, 0, 0, 5, 5, 7, 7)
#    play color.tick(:color) + transpose.tick(:trans)
