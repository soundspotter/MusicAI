# =====================================================================
# Information Content — Measuring Musical Surprise
# =====================================================================
# Music and AI — Week 3
#
# Information Content (Shannon, 1948; Pearce IDyOM, 2005):
#   IC(x) = -log2( P(x | context) )
#
# High IC = surprising/unexpected event (low probability)
# Low IC = predictable/expected event (high probability)
#
# A note that follows common patterns has low IC.
# A note that breaks expectations has high IC.
# Musical interest often correlates with moderate IC —
# too predictable is boring, too surprising is chaotic.
#
# Mean IC (entropy) of a sequence measures overall predictability.

use_random_seed 42

# =====================================================================
# Part 1: Build probability model
# =====================================================================

define :build_prob_model do |melody, order|
  counts_model = {}
  (melody.length - order).times do |i|
    ctx = melody[i, order].to_s
    nxt = melody[i + order]
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

# =====================================================================
# Part 2: Compute IC for each note in a melody
# =====================================================================

define :compute_ic do |melody, model, order|
  ic_values = []
  # First 'order' notes have no context — assign IC = 0
  order.times { ic_values.push(0) }
  (order...melody.length).each do |i|
    ctx = melody[i - order, order].to_s
    note = melody[i]
    probs = model[ctx]
    if probs != nil && probs[note] != nil
      ic = -Math.log2(probs[note])  # IC = -log2(P)
    else
      ic = 8.0  # Max surprise for unseen events
    end
    ic_values.push(ic)
  end
  ic_values
end

# =====================================================================
# Part 3: Training data and analysis
# =====================================================================

melody = [60,60,67,67,69,69,67, 65,65,64,64,62,62,60,
          67,67,65,65,64,64,62, 67,67,65,65,64,64,62,
          60,60,67,67,69,69,67, 65,65,64,64,62,62,60]

# Build model and compute IC
model = build_prob_model(melody, 1)
ic = compute_ic(melody, model, 1)

# =====================================================================
# Part 4: Display results
# =====================================================================

note_names = ["C","C#","D","Eb","E","F","F#","G","Ab","A","Bb","B"]

puts "=== Information Content Analysis ==="
puts "Note\tIC (bits)"
melody.each_with_index do |m, i|
  name = note_names[m % 12]
  puts "#{name}\t#{ic[i].round(2)}"
end

# Statistics
mean_ic = ic.reduce(:+) / ic.length.to_f
max_ic = ic.max
non_zero = ic.select { |v| v > 0 }
min_ic = non_zero.empty? ? 0 : non_zero.min

puts ""
puts "Mean IC (entropy): #{mean_ic.round(2)} bits"
puts "Max IC: #{max_ic.round(2)} bits (most surprising note)"
puts "Min IC: #{min_ic.round(2)} bits (most predictable note)"

# Find most surprising moments
puts ""
puts "Most surprising notes:"
ic.each_with_index do |val, i|
  if val > 2
    puts "  Position #{i}: #{note_names[melody[i] % 12]} (IC = #{val.round(2)} bits)"
  end
end

# =====================================================================
# Part 5: Visualize IC as amplitude
# =====================================================================
# Play melody with amplitude proportional to IC
# (surprising notes are louder)

# Normalize IC to amplitude range [0.1, 0.8]
ic_min = ic.min
ic_max = ic.max
ic_range = (ic_max - ic_min)
ic_range = 1.0 if ic_range == 0
ic_amps = ic.map { |v| 0.1 + 0.7 * ((v - ic_min) / ic_range) }

live_loop :ic_melody do
  use_synth :piano
  melody.each_with_index do |n, i|
    play n, amp: ic_amps[i], sustain: 0.3, release: 0.1
    sleep 0.4
  end
  stop
end

sleep melody.length * 0.4 + 2

# =====================================================================
# Part 6: Compare original vs. generated IC
# =====================================================================

order2 = 2
model2 = build_prob_model(melody, order2)

# Generate a new melody
generated = melody[0, 2].dup  # Seed
30.times do
  ctx = generated.last(order2).to_s
  probs = model2[ctx]
  if probs != nil
    # Weighted random choice
    items = probs.keys
    weights = probs.values
    total = weights.reduce(:+)
    r = rand * total
    cumul = 0.0
    chosen = items.last
    items.each_with_index do |item, j|
      cumul += weights[j]
      if cumul >= r
        chosen = item
        break
      end
    end
    generated.push(chosen)
  else
    generated.push(melody.choose)
  end
end

ic_original = compute_ic(melody, model2, order2)
ic_generated = compute_ic(generated, model2, order2)

mean_orig = ic_original.reduce(:+) / ic_original.length.to_f
mean_gen = ic_generated.reduce(:+) / ic_generated.length.to_f

# Standard deviation helper
define :std_dev do |arr|
  mean = arr.reduce(:+) / arr.length.to_f
  variance = arr.map { |v| (v - mean) ** 2 }.reduce(:+) / arr.length.to_f
  Math.sqrt(variance)
end

puts ""
puts "Original  -- Mean IC: #{mean_orig.round(2)}, Std: #{std_dev(ic_original).round(2)}"
puts "Generated -- Mean IC: #{mean_gen.round(2)}, Std: #{std_dev(ic_generated).round(2)}"

# --- Experiment ---
# 1. How does Markov order affect mean IC?
#    (Higher order -> lower IC for training data)
# 2. Compare IC of original vs. generated melodies
# 3. Do you prefer melodies with moderate IC? Test with listeners.
# 4. Train on one piece, compute IC for a different piece
#    (cross-entropy — measures style similarity)
