# =====================================================================
# Voice Leading — Smooth Chord Progressions
# =====================================================================
# Music and AI — Week 3
#
# Voice leading: the art of moving individual voices (notes) as
# smoothly as possible between chords. Good voice leading:
#   1. Minimizes the total distance voices move
#   2. Prefers stepwise motion (intervals of 1-2 semitones)
#   3. Avoids parallel perfect intervals (5ths, octaves)
#   4. Keeps common tones between chords
#
# This is a constraint satisfaction problem: find the voicing of
# each chord that satisfies all rules while minimizing motion.

use_random_seed 42

# =====================================================================
# Part 1: Chord definitions (scale degrees)
# =====================================================================

chords = {
  I:   [0, 2, 4],      # C E G
  ii:  [1, 3, 5],      # D F A
  iii: [2, 4, 6],      # E G B
  IV:  [3, 5, 7],      # F A C
  V:   [4, 6, 8],      # G B D
  vi:  [5, 7, 9],      # A C E
  vii: [6, 8, 10],     # B D F
}

# =====================================================================
# Part 2: Find closest voicing
# =====================================================================
# Given a target chord and current voicing, find the arrangement
# of target that minimizes total voice movement.
# Greedy assignment: each voice moves to its nearest target note.

define :closest_voicing do |current, target_degrees|
  num_voices = current.length

  # For each voice, compute distance to each target degree
  # considering multiple octave placements
  best_options = (0...num_voices).map do |i|
    curr = current[i]
    target_degrees.map do |t|
      options = (-2..2).map { |oct| t + (oct * 7) }
      options.min_by { |o| (o - curr).abs }
    end
  end

  # Greedy assignment: each voice moves to nearest available target
  assigned = Array.new(num_voices, nil)
  used = Array.new(target_degrees.length, false)

  num_voices.times do |v|
    min_dist = 100
    best_target_idx = 0
    best_options[v].each_with_index do |opt, t|
      if !used[t] && (opt - current[v]).abs < min_dist
        min_dist = (opt - current[v]).abs
        best_target_idx = t
        assigned[v] = opt
      end
    end
    used[best_target_idx] = true
  end

  assigned
end

# =====================================================================
# Part 3: Compute voice-led progression
# =====================================================================

progression = [:I, :vi, :IV, :V, :I, :IV, :ii, :V]

# Start with root position I chord
current_voicing = [0, 2, 4]  # C E G in scale degrees

voicings = [current_voicing.dup]

progression.drop(1).each do |chord_name|
  target = chords[chord_name]
  current_voicing = closest_voicing(current_voicing, target)
  voicings.push(current_voicing.dup)
  puts "#{chord_name} -> #{current_voicing}"
end

# =====================================================================
# Part 4: Play the voice-led progression
# =====================================================================

use_bpm 72

live_loop :voice_leading do
  use_synth :piano
  voicings.each do |voicing|
    # Play all notes of the chord with slight strum
    voicing.each_with_index do |deg, i|
      play degree(deg, 4, :major), amp: 0.3, sustain: 1.8, release: 0.2
      sleep 0.05  # Slight strum for clarity
    end
    sleep 2 - (voicing.length * 0.05)  # Total beat = 2
  end
  # Play twice
  voicings.each do |voicing|
    voicing.each_with_index do |deg, i|
      play degree(deg, 4, :major), amp: 0.3, sustain: 1.8, release: 0.2
      sleep 0.05
    end
    sleep 2 - (voicing.length * 0.05)
  end
  stop
end

sleep voicings.length * 2 * 2 + 2

# =====================================================================
# Part 5: Compare — with vs. without voice leading
# =====================================================================

# Without voice leading (root position every time)
root_position = progression.map { |name| chords[name] }

puts ""
puts "=== Without voice leading (root position) ==="
root_position.each_with_index { |v, i| puts "#{progression[i]} -> #{v}" }

puts ""
puts "=== With voice leading ==="
voicings.each_with_index { |v, i| puts "#{progression[i]} -> #{v}" }

live_loop :no_voice_leading do
  use_synth :piano
  puts "Playing WITHOUT voice leading..."
  root_position.each do |voicing|
    voicing.each do |deg|
      play degree(deg, 4, :major), amp: 0.3, sustain: 1.8, release: 0.2
      sleep 0.05
    end
    sleep 2 - (voicing.length * 0.05)
  end
  # Repeat
  root_position.each do |voicing|
    voicing.each do |deg|
      play degree(deg, 4, :major), amp: 0.3, sustain: 1.8, release: 0.2
      sleep 0.05
    end
    sleep 2 - (voicing.length * 0.05)
  end
  stop
end

# Listen to both — the voice-led version should sound smoother

# --- Experiment ---
# 1. Try longer progressions: I-vi-ii-V-I-IV-V-I
# 2. Add a 4th voice (double the root or fifth)
# 3. Try minor scale: change :major to :minor
# 4. Add a penalty for parallel 5ths in the voicing algorithm
# 5. Compare the total voice movement (sum of intervals) for each version
