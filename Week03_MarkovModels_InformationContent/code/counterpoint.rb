# =====================================================================
# Constrained Composition & Counterpoint
# =====================================================================
# Music and AI — Week 3
#
# Constrained composition: Generate music that satisfies explicit rules.
# Unlike Markov chains (which learn patterns statistically), constraint-
# based approaches encode musical knowledge directly:
#   - Avoid parallel fifths and octaves
#   - Voices should move by step when possible
#   - Contrary motion is preferred
#   - Dissonances must resolve
#
# This connects to:
#   - Traditional counterpoint rules (Fux, 1725)
#   - Constraint satisfaction problems (CSP) in AI
#   - Backtracking search algorithms
#
# From the course's scwork/system/patterns/counterpoint.scd

use_random_seed 42

# =====================================================================
# Part 1: Euclidean rhythm helper
# =====================================================================
# Generates Euclidean rhythm durations (Bjorklund algorithm)
# k onsets spread as evenly as possible across n steps

define :euclidean_durs do |k, n|
  onsets = (0...k).map { |i| ((i * n.to_f / k).floor) % n }
  onsets.sort!
  durs = (0...k).map do |i|
    nxt = (i < k - 1) ? onsets[i + 1] : (onsets[0] + n)
    (nxt - onsets[i]).to_f / n
  end
  durs
end

# =====================================================================
# Part 2: Constrained voice generator
# =====================================================================
# Generates a single voice with random scale degrees and Euclidean rhythm

define :make_voice do |scale_name, octave, n, bar_len|
  all_degrees = (0..5).to_a + (0..5).to_a + [:r, :r]
  degrees = all_degrees.shuffle[0, n]
  durs = euclidean_durs(n, bar_len).map { |d| d * 2 }
  { degrees: degrees, durs: durs, scale: scale_name, octave: octave }
end

# =====================================================================
# Part 3: Interval computation (for constraint checking)
# =====================================================================

define :all_intervals do |chord|
  intervals = []
  (1...chord.length).each do |gap|
    (0...(chord.length - gap)).each do |i|
      intervals.push(chord[i + gap] - chord[i])
    end
  end
  intervals
end

# =====================================================================
# Part 4: Voice leading constraint
# =====================================================================
# Check that voices move by step (interval <= 2 scale degrees)

define :good_voice_leading do |prev, curr|
  motion = (curr - prev).abs
  motion <= 2  # Step motion preferred
end

# =====================================================================
# Part 5: Parallel fifths/octaves check
# =====================================================================

define :no_parallels do |prev_chord, curr_chord|
  prev_int = all_intervals(prev_chord)
  curr_int = all_intervals(curr_chord)
  has_parallel = false
  prev_int.each_with_index do |pi, i|
    if i < curr_int.length && pi == curr_int[i]
      if [0, 7, 12].include?(curr_int[i] % 12)
        has_parallel = true
      end
    end
  end
  !has_parallel
end

# =====================================================================
# Part 6: Multi-voice counterpoint playback
# =====================================================================
# Three voices with Euclidean rhythms on different scales

use_bpm 100

pat_lengths = [7, 11, 13, 17, 23]  # Prime numbers for rhythmic variety
scale_name = :dorian

# Voice 1 — high register
voice1 = make_voice(scale_name, 5, pat_lengths.choose, 32)
# Voice 2 — middle register
voice2 = make_voice(scale_name, 4, pat_lengths.choose, 32)
# Voice 3 — low register
voice3 = make_voice(scale_name, 3, pat_lengths.choose, 32)

live_loop :voice_high do
  use_synth :saw
  v = voice1
  v[:degrees].each_with_index do |deg, i|
    if deg == :r
      sleep v[:durs][i]
    else
      play_pattern_timed(
        [degree(deg, v[:octave], v[:scale])],
        [v[:durs][i]],
        amp: 0.25, release: v[:durs][i] * 0.8
      )
    end
  end
  stop
end

live_loop :voice_mid do
  use_synth :tri
  v = voice2
  v[:degrees].each_with_index do |deg, i|
    if deg == :r
      sleep v[:durs][i]
    else
      play_pattern_timed(
        [degree(deg, v[:octave], v[:scale])],
        [v[:durs][i]],
        amp: 0.25, release: v[:durs][i] * 0.8
      )
    end
  end
  stop
end

live_loop :voice_low do
  use_synth :fm
  v = voice3
  v[:degrees].each_with_index do |deg, i|
    if deg == :r
      sleep v[:durs][i]
    else
      play_pattern_timed(
        [degree(deg, v[:octave], v[:scale])],
        [v[:durs][i]],
        amp: 0.25, release: v[:durs][i] * 0.8
      )
    end
  end
  stop
end

sleep 16

# =====================================================================
# Part 7: Phrase-based composition
# =====================================================================
# Pre-composed phrases combined randomly

phrases = [
  { degrees: [0, -2, 1, 2, 1, 6, 4],
    durs: [0.75, 0.25, 0.25, 0.5, 0.25, 0.75, 0.75] },
  { degrees: [7, 4, 3, 1, -2, 0, 1],
    durs: [0.5, 0.75, 0.25, 0.5, 0.25, 0.25, 0.75] },
  { degrees: [2, 1, 0, 1, 2, 4, 5, 1],
    durs: [0.25, 0.25, 0.25, 0.25, 0.25, 0.25, 0.25, 0.75] },
  { degrees: [4, 5, 4, 5, 7, 8, 7, 9, 6],
    durs: [0.5, 0.5, 0.25, 0.25, 0.25, 0.5, 0.25, 0.75, 0.75] },
]

live_loop :phrase_based do
  use_synth :piano
  8.times do  # Play 8 random phrases
    phrase = phrases.choose
    phrase[:degrees].each_with_index do |deg, i|
      play degree(deg, 5, :dorian), amp: 0.4, release: phrase[:durs][i] * 0.8
      sleep phrase[:durs][i]
    end
  end
  stop
end

# --- Experiment ---
# 1. Modify make_voice to enforce step-motion constraints
# 2. Add rules: no parallel 5ths, resolve dissonances
# 3. Compare: random generation vs. constrained generation
# 4. Try different scales: :phrygian, :lydian, :whole
# 5. Change pat_lengths to non-prime numbers — hear the difference?
