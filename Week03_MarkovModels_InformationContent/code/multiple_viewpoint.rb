# =====================================================================
# Multiple Viewpoint Markov Model
# =====================================================================
# Music and AI — Week 3
#
# A single Markov chain over pitch captures melodic patterns but
# ignores rhythm. A chain over duration captures rhythmic patterns
# but ignores melody. A multiple viewpoint model combines them.
#
# Key idea (Conklin & Witten, 1995; Pearce, 2005):
# P(note | context) ~ P_pitch(note | pitch_context) * P_rhythm(dur | rhythm_context)
#
# Each "viewpoint" (pitch, duration, interval, etc.) has its own
# Markov model. Their predictions are combined via the product rule
# (or geometric mean) to generate notes that are plausible in
# ALL viewpoints simultaneously.

use_random_seed 42

# =====================================================================
# Part 1: Training data — melody with durations
# =====================================================================
# Each element is [midinote, duration]

training_data = [
  [60, 1], [60, 1], [67, 1], [67, 1], [69, 0.5], [69, 0.5], [67, 2],
  [65, 1], [65, 1], [64, 1], [64, 1], [62, 0.5], [62, 0.5], [60, 2],
  [67, 1], [67, 1], [65, 0.5], [65, 0.5], [64, 1], [64, 1], [62, 2],
  [67, 1], [67, 1], [65, 0.5], [65, 0.5], [64, 1], [64, 1], [62, 2],
  [60, 1], [60, 1], [67, 1], [67, 1], [69, 0.5], [69, 0.5], [67, 2],
  [65, 1], [65, 1], [64, 1], [64, 1], [62, 0.5], [62, 0.5], [60, 2],
]

# =====================================================================
# Part 2: Extract viewpoints
# =====================================================================

pitches = training_data.map { |nd| nd[0] }
durations = training_data.map { |nd| nd[1] }
intervals = (1...pitches.length).map { |i| pitches[i] - pitches[i - 1] }

# =====================================================================
# Part 3: Build probability model for a single viewpoint
# =====================================================================
# Returns Hash: context_string => { value => probability }

define :build_prob_model do |seq, order|
  counts_model = {}
  (seq.length - order).times do |i|
    ctx = seq[i, order].to_s
    nxt = seq[i + order]
    counts_model[ctx] = [] unless counts_model.include?(ctx)
    counts_model[ctx].push(nxt)
  end
  # Convert to probability distributions
  prob_model = {}
  counts_model.each do |ctx, nexts|
    counts = {}
    nexts.each { |n| counts[n] = (counts[n] || 0) + 1 }
    total = nexts.length.to_f
    probs = {}
    counts.each { |n, c| probs[n] = c / total }
    prob_model[ctx] = probs
  end
  prob_model
end

pitch_model = build_prob_model(pitches, 1)
dur_model = build_prob_model(durations, 1)
interval_model = build_prob_model(intervals, 1)

# =====================================================================
# Part 4: Weighted random sampling from a probability Hash
# =====================================================================

define :weighted_choose do |probs_hash|
  return nil if probs_hash == nil || probs_hash.empty?
  items = probs_hash.keys
  weights = probs_hash.values
  total = weights.reduce(:+)
  r = rand * total
  cumul = 0.0
  items.each_with_index do |item, i|
    cumul += weights[i]
    return item if cumul >= r
  end
  items.last
end

# =====================================================================
# Part 5: Multiple viewpoint generation
# =====================================================================
# Combine pitch and interval viewpoints via product rule

define :generate_mv do |length, pitch_mdl, dur_mdl, int_mdl, all_pitches, all_durs|
  output = [[all_pitches[0], all_durs[0]]]

  (length - 1).times do |i|
    # --- Pitch viewpoint ---
    p_ctx = [output.last[0]].to_s
    p_probs = pitch_mdl[p_ctx] || {}

    # --- Interval viewpoint ---
    i_probs = {}
    if output.length > 1
      interval = output.last[0] - output[-2][0]
      i_ctx = [interval].to_s
      i_probs = int_mdl[i_ctx] || {}
    end

    # --- Duration viewpoint ---
    d_ctx = [output.last[1]].to_s
    d_probs = dur_mdl[d_ctx] || {}

    # --- Combine pitch viewpoints via product rule ---
    if p_probs.length > 0
      candidates = p_probs.keys
      if i_probs.length > 0
        # Map interval predictions to absolute pitches
        int_pitches = {}
        i_probs.each { |intv, w| int_pitches[output.last[0] + intv] = w }

        combined = {}
        candidates.each do |p|
          p_weight = p_probs[p]
          i_weight = int_pitches[p] || 0.1  # Default small weight
          combined[p] = p_weight * i_weight
        end
        best_pitch = weighted_choose(combined)
        best_pitch = candidates.choose if best_pitch == nil
      else
        best_pitch = weighted_choose(p_probs)
      end
    else
      best_pitch = all_pitches.choose  # Fallback
    end

    # --- Sample duration ---
    if d_probs.length > 0
      best_dur = weighted_choose(d_probs)
    else
      best_dur = all_durs.choose
    end

    output.push([best_pitch, best_dur])
  end
  output
end

# =====================================================================
# Part 6: Generate and display
# =====================================================================

mv_melody = generate_mv(32, pitch_model, dur_model, interval_model, pitches, durations)

puts "Generated melody (multiple viewpoint):"
mv_melody.each_with_index do |note, i|
  puts "  #{i}: pitch=#{note[0]}, dur=#{note[1]}"
end

# =====================================================================
# Part 7: Play the generated melody
# =====================================================================

live_loop :multi_view do
  use_synth :piano
  mv_melody.each do |note|
    play note[0], amp: 0.4, sustain: note[1] * 0.4, release: 0.1
    sleep note[1] * 0.5
  end
  stop
end

# --- Experiment ---
# 1. Try higher order models (order 2). How does it change the output?
# 2. Weight the viewpoints differently: pitch * 0.7 + interval * 0.3
# 3. Add a third viewpoint: contour (up/down/same)
# 4. Train on a different melody — does the style transfer?
# 5. Compare single-viewpoint pitch model vs. multiple viewpoint
