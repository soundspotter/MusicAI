# =====================================================================
# Sampling Strategies for Sequence Generation
# =====================================================================
# Music and AI — Week 3
#
# Given a probability distribution over next notes, HOW we sample
# from it dramatically affects the output character:
#
# Greedy:      Always pick the highest probability note
#              -> Deterministic, repetitive, but "safe"
#
# Temperature: Scale logits before softmax. t<1 = sharper (more
#              deterministic), t>1 = flatter (more random)
#              P'(x) ~ P(x)^(1/t)
#
# Top-k:       Only sample from the k most likely notes
#              -> Prevents very unlikely choices
#
# Nucleus (top-p): Sample from the smallest set whose cumulative
#              probability exceeds p. Adaptive — more options when
#              distribution is flat, fewer when peaked.
#
# These are the SAME strategies used in LLMs (GPT, Claude, etc.)
# for text generation!

use_random_seed 42

# =====================================================================
# Part 1: Build model from corpus
# =====================================================================

corpus = [60,60,67,67,69,69,67, 65,65,64,64,62,62,60,
          67,67,65,65,64,64,62, 67,67,65,65,64,64,62,
          60,60,67,67,69,69,67, 65,65,64,64,62,62,60]

define :build_model do |melody, order|
  model = {}
  (melody.length - order).times do |i|
    ctx = melody[i, order].to_s
    nxt = melody[i + order]
    model[ctx] = [] unless model.include?(ctx)
    model[ctx].push(nxt)
  end
  model
end

define :get_probs do |model, context|
  nexts = model[context.to_s]
  return {} if nexts == nil
  counts = {}
  nexts.each { |n| counts[n] = (counts[n] || 0) + 1 }
  total = nexts.length.to_f
  probs = {}
  counts.each { |n, c| probs[n] = c / total }
  probs
end

model = build_model(corpus, 1)

# =====================================================================
# Part 2: Greedy sampling
# =====================================================================
# Always pick the highest probability note

define :greedy_sample do |probs|
  best = nil
  max_prob = 0
  probs.each do |note, prob|
    if prob > max_prob
      max_prob = prob
      best = note
    end
  end
  best
end

# =====================================================================
# Part 3: Temperature sampling
# =====================================================================
# P'(x) ~ P(x)^(1/t)

define :temperature_sample do |probs, temperature|
  temperature = 0.01 if temperature <= 0  # Avoid division by zero
  notes = probs.keys
  ps = probs.values.map { |p| p ** (1.0 / temperature) }
  total = ps.reduce(:+)
  ps = ps.map { |p| p / total }
  # Weighted random selection via cumulative probability
  r = rand
  cumul = 0.0
  notes.each_with_index do |note, i|
    cumul += ps[i]
    return note if cumul >= r
  end
  notes.last
end

# =====================================================================
# Part 4: Top-k sampling
# =====================================================================
# Only sample from the k most likely notes

define :top_k_sample do |probs, k|
  # Sort by probability descending
  sorted = probs.sort_by { |_n, p| -p }
  top = sorted[0, [k, sorted.length].min]
  notes = top.map { |pair| pair[0] }
  ps = top.map { |pair| pair[1] }
  total = ps.reduce(:+)
  ps = ps.map { |p| p / total }
  # Weighted random
  r = rand
  cumul = 0.0
  notes.each_with_index do |note, i|
    cumul += ps[i]
    return note if cumul >= r
  end
  notes.last
end

# =====================================================================
# Part 5: Nucleus (top-p) sampling
# =====================================================================
# Sample from smallest set whose cumulative prob exceeds p

define :nucleus_sample do |probs, p_threshold|
  sorted = probs.sort_by { |_n, p| -p }
  cumul = 0.0
  nucleus = []
  sorted.each do |pair|
    if cumul < p_threshold
      nucleus.push(pair)
      cumul += pair[1]
    end
  end
  nucleus.push(sorted[0]) if nucleus.empty?
  notes = nucleus.map { |pair| pair[0] }
  ps = nucleus.map { |pair| pair[1] }
  total = ps.reduce(:+)
  ps = ps.map { |p| p / total }
  # Weighted random
  r = rand
  cumul = 0.0
  notes.each_with_index do |note, i|
    cumul += ps[i]
    return note if cumul >= r
  end
  notes.last
end

# =====================================================================
# Part 6: Generate melodies with each strategy
# =====================================================================

define :generate_with do |strategy, args, mdl, crps, length|
  output = [crps[0]]
  (length - 1).times do
    ctx = [output.last]
    probs = get_probs(mdl, ctx)
    if probs.length > 0
      case strategy
      when :greedy
        nxt = greedy_sample(probs)
      when :temp
        nxt = temperature_sample(probs, args[0])
      when :top_k
        nxt = top_k_sample(probs, args[0])
      when :nucleus
        nxt = nucleus_sample(probs, args[0])
      end
    else
      nxt = crps.choose
    end
    output.push(nxt)
  end
  output
end

puts "=== Sampling Strategy Comparison ==="

strategies = [
  [:greedy,  [],    "Greedy (deterministic)"],
  [:temp,    [0.3], "Temperature 0.3 (conservative)"],
  [:temp,    [1.0], "Temperature 1.0 (standard)"],
  [:temp,    [2.0], "Temperature 2.0 (creative)"],
  [:top_k,   [3],   "Top-k (k=3)"],
  [:nucleus, [0.9], "Nucleus (p=0.9)"],
]

melodies = {}
strategies.each do |strat|
  name = strat[0].to_s + "_" + strat[1].to_s
  mel = generate_with(strat[0], strat[1], model, corpus, 32)
  melodies[name] = mel
  puts "#{strat[2]}: #{mel}"
end

# =====================================================================
# Part 7: Play each strategy
# =====================================================================
# Change which_strategy to compare

which_strategy = 2  # Index into strategies array (0-5)
strat = strategies[which_strategy]
name = strat[0].to_s + "_" + strat[1].to_s

puts ""
puts "Playing: #{strat[2]}"

live_loop :sampling do
  use_synth :piano
  melodies[name].each do |n|
    play n, amp: 0.4, sustain: 0.15, release: 0.05
    sleep 0.25
  end
  stop
end

sleep melodies[name].length * 0.25 + 2

# =====================================================================
# Part 8: Play all strategies in sequence for comparison
# =====================================================================

live_loop :compare_all do
  use_synth :piano
  strategies.each do |strat_info|
    nm = strat_info[0].to_s + "_" + strat_info[1].to_s
    label = strat_info[2]
    puts "Now playing: #{label}"
    sleep 1  # Pause before
    melodies[nm].each do |n|
      play n, amp: 0.4, sustain: 0.15, release: 0.05
      sleep 0.25
    end
    sleep 2  # Pause between strategies
  end
  stop
end

# --- Experiment ---
# 1. Listen to greedy vs. temperature 2.0 — which is more musical?
# 2. Try temperature values: 0.1, 0.5, 1.0, 1.5, 3.0
# 3. How does top-k with k=1 compare to greedy?
# 4. Nucleus with p=0.5 vs p=0.99 — hear the difference?
# 5. Which strategy best balances novelty and coherence?
# 6. These are the SAME controls used in ChatGPT/Claude — try them!
