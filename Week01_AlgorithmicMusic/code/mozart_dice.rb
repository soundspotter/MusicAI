# =====================================================================
# Mozart's Musikalisches Wurfelspiel -- Musical Dice Game (K.516f)
# =====================================================================
# Music and AI -- Week 1
#
# Published posthumously in 1792 by Nikolaus Simrock.
# A 16-bar minuet is composed by rolling dice to select from
# pre-composed measures. Each bar position has 11 possible choices
# (sum of two dice: 2-12), giving 11^16 ~ 4.6 x 10^16 possible minuets.
#
# This demonstrates combinatorial composition -- the earliest form of
# "algorithmic" music, predating computers by 200+ years.
#
# Key insight: Every possible output sounds like a valid Mozart minuet
# because ALL the musical material was composed by Mozart. The algorithm
# only selects and arranges -- it does not generate new material.
# =====================================================================


# --- Historical minuet table ---
# Each row = one bar position (0-15)
# Each column = dice sum - 2 (index 0-10, for dice sums 2-12)
# Values are melodic fragments as scale degrees (4 notes per measure)
#
# In Mozart's original, these were measure numbers referencing a
# catalog of 176 pre-composed measures. Here we use simplified
# 4-note melodic fragments in scale degrees for playback.

minuet_table = [
  # Bar 0: 11 options (one for each possible dice sum 2-12)
  [[0,2,4,5], [4,2,4,7], [0,0,2,4], [2,4,5,7], [0,1,2,4],
   [4,5,7,9], [0,2,4,2], [7,5,4,2], [0,4,7,4], [2,0,2,4], [4,7,9,7]],
  # Bar 1
  [[5,4,2,0], [7,5,4,2], [9,7,5,4], [4,2,4,5], [2,4,5,7],
   [0,2,0,-1], [5,7,5,4], [4,2,0,2], [7,9,7,5], [5,4,2,4], [2,0,2,5]],
  # Bar 2
  [[4,5,7,9], [2,4,5,4], [0,2,4,5], [7,5,4,2], [5,7,9,7],
   [4,2,0,2], [9,7,5,4], [2,4,7,5], [0,4,2,0], [5,4,7,5], [7,9,11,9]],
  # Bar 3
  [[2,0,-1,0], [4,5,4,2], [0,2,4,7], [5,4,2,0], [7,5,4,5],
   [2,4,2,0], [0,-1,0,2], [4,2,0,-1], [5,7,5,4], [7,9,7,5], [9,7,5,4]],
  # Bar 4
  [[0,4,7,4], [2,0,2,4], [4,7,9,7], [0,2,0,-1], [5,4,2,0],
   [7,5,7,9], [4,2,4,5], [0,-1,0,2], [2,4,5,7], [7,9,11,7], [5,7,5,4]],
  # Bar 5
  [[4,2,0,2], [5,7,5,4], [7,5,4,2], [0,2,4,5], [2,0,-1,0],
   [9,7,5,7], [4,5,4,2], [7,9,7,5], [0,4,2,0], [5,4,5,7], [2,4,7,9]],
  # Bar 6
  [[7,5,4,2], [0,2,4,7], [5,4,2,0], [4,7,5,4], [2,4,5,7],
   [0,-1,0,2], [9,7,5,4], [7,5,7,9], [4,2,4,5], [5,7,9,7], [0,4,7,11]],
  # Bar 7 (half cadence -- all options end on degree 4 for dominant feel)
  [[4,2,0,4], [7,4,2,4], [0,4,7,4], [5,4,2,4], [2,4,0,4],
   [4,7,4,2], [0,2,4,7], [7,5,4,2], [4,0,4,7], [2,7,4,2], [0,7,4,0]],
  # Bar 8 (second half begins)
  [[0,2,4,5], [7,5,4,2], [4,5,7,9], [2,0,2,4], [5,4,2,0],
   [0,4,7,4], [9,7,5,4], [4,2,0,2], [7,9,7,5], [2,4,5,7], [5,7,9,11]],
  # Bar 9
  [[4,2,0,-1], [5,4,5,7], [0,2,4,5], [7,5,4,2], [2,4,7,5],
   [4,5,4,2], [9,7,9,7], [0,-1,0,2], [5,7,5,4], [7,9,7,5], [4,2,4,7]],
  # Bar 10
  [[0,4,7,9], [2,0,2,4], [5,4,2,0], [4,5,7,5], [7,5,4,2],
   [0,2,0,-1], [9,7,5,7], [4,2,4,5], [2,4,5,7], [5,7,9,7], [7,9,11,9]],
  # Bar 11
  [[4,2,0,2], [0,2,4,5], [7,5,4,2], [5,4,5,7], [2,0,-1,0],
   [4,7,5,4], [0,4,2,0], [9,7,5,4], [5,7,9,7], [7,5,7,9], [2,4,7,5]],
  # Bar 12
  [[0,2,4,7], [5,4,2,0], [4,5,4,2], [2,4,5,7], [7,5,7,9],
   [0,-1,0,2], [4,2,0,4], [9,7,5,4], [5,7,5,4], [7,9,7,5], [2,0,2,4]],
  # Bar 13
  [[5,4,2,0], [0,2,4,5], [7,5,4,2], [4,7,5,4], [2,4,5,7],
   [9,7,9,7], [0,4,7,4], [5,7,5,4], [4,2,0,2], [7,5,4,5], [0,-1,0,2]],
  # Bar 14
  [[4,5,7,5], [2,0,2,4], [0,4,2,0], [5,4,2,4], [7,9,7,5],
   [4,2,4,7], [0,2,0,-1], [9,7,5,4], [2,4,5,7], [5,7,9,7], [7,5,4,2]],
  # Bar 15 (final cadence -- all options resolve to scale degree 0)
  [[4,2,0,0], [0,4,2,0], [7,4,0,0], [2,0,4,0], [5,2,0,0],
   [4,0,7,0], [0,7,4,0], [7,0,4,0], [4,2,7,0], [2,4,0,0], [0,2,4,0]],
]

# --- Helper: convert scale degree to MIDI note ---
# C major scale, degree 0 = C
define :degree_to_midi do |deg, octave|
  c_major = [0, 2, 4, 5, 7, 9, 11]
  # Handle negative degrees (e.g., -1 = B below)
  oct_offset = 0
  d = deg
  while d < 0
    d += 7
    oct_offset -= 1
  end
  while d >= 7
    d -= 7
    oct_offset += 1
  end
  (octave + oct_offset) * 12 + c_major[d]
end


# =============================================
# Part 1: Single-voice dice minuet
# =============================================

use_random_seed Time.now.to_i  # Unique composition each run
use_bpm 120

puts ""
puts "========================================"
puts "Mozart's Dice Game"
puts "========================================"
puts "Rolling dice for 16 bars..."

# Roll dice and compose
composition = []
bass_line = []

16.times do |bar|
  die1 = rrand_i(1, 6)
  die2 = rrand_i(1, 6)
  dice_sum = die1 + die2
  table_index = dice_sum - 2  # Map sum 2-12 to index 0-10
  puts "  Bar #{bar + 1}: dice = #{die1} + #{die2} = #{dice_sum}, selecting option #{table_index}"
  measure = minuet_table[bar][table_index]
  composition.push(measure)
  bass_line.push(measure[0])  # Bass takes first note of each measure
end

puts ""
puts "Playing minuet (with first-half repeat)..."
puts "Form: |: bars 1-8 :| bars 9-16"

# Build the full melody sequence: |: bars 1-8 :| bars 9-16
melody = composition[0..7].flatten +   # First half
         composition[0..7].flatten +   # Repeat first half
         composition[8..15].flatten    # Second half

# Play melody
use_synth :beep
melody.each do |deg|
  play degree_to_midi(deg, 5), amp: 0.4, sustain: 0.35, release: 0.05
  sleep 0.5
end


# =============================================
# Part 2: Two-voice version
# =============================================
# Add a simple bass line that follows the harmonic implications.
# Comment out Part 1 above before running this section.

=begin
use_random_seed 99  # Try different seeds
use_bpm 120

composition2 = []
bass_line2 = []

16.times do |bar|
  dice_sum = rrand_i(1, 6) + rrand_i(1, 6)
  measure = minuet_table[bar][dice_sum - 2]
  composition2.push(measure)
  bass_line2.push(measure[0])
end

# Build sequences with repeat
melody2 = composition2[0..7].flatten +
          composition2[0..7].flatten +
          composition2[8..15].flatten

bass2 = bass_line2[0..7] +
        bass_line2[0..7] +
        bass_line2[8..15]

puts "Two-voice Mozart dice minuet (seed 99)"

# Melody voice
in_thread do
  use_synth :beep
  melody2.each do |deg|
    play degree_to_midi(deg, 5), amp: 0.35, sustain: 0.35, release: 0.05
    sleep 0.5
  end
end

# Bass voice (whole notes, one per bar = 4 eighth notes = 2 beats)
in_thread do
  use_synth :beep
  bass2.each do |deg|
    play degree_to_midi(deg, 3), amp: 0.3, sustain: 1.8, release: 0.2
    sleep 2
  end
end
=end


# --- Thinking about the numbers ---
#
# 16 bars, each with 11 options = 11^16 possible minuets
# 11^16 = 45,949,729,863,572,161 ~ 4.6 x 10^16
#
# If you generated one minuet per second, it would take
# about 1.5 billion years to hear them all.
#
# Yet every single one sounds like a plausible Mozart minuet.
# This is because the "creativity" is in the pre-composed fragments
# and the constraints on how they connect (harmonic structure,
# cadence points), not in the selection algorithm.
#
# --- Experiments ---
#
# 1. Change use_random_seed to get a different minuet
#
# 2. Is this "algorithmic composition" or "algorithmic arrangement"?
#
# 3. How is this different from (or similar to) a modern AI model
#    trained on Mozart's music?
#
# 4. Try different synths: :piano, :pluck, :saw
#
# 5. Add a third voice (e.g., an inner voice playing chord tones)
