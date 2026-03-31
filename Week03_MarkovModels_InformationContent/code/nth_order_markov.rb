# =====================================================================
# Nth-Order Markov Chain Melody Generation
# =====================================================================
# Music and AI — Week 3
#
# A Markov chain generates sequences where each element depends
# only on the previous n elements (the "context" or "state").
#
# Order 0: Random selection from distribution (no memory)
# Order 1: Next note depends on current note
# Order 2: Next note depends on last 2 notes
# Order n: Next note depends on last n notes
#
# Higher order = more faithful to training data, but less novel.
# Too high = just replaying the original. Too low = random noise.
# The sweet spot depends on corpus size and musical goals.

use_random_seed 42

# =====================================================================
# Part 1: Training corpus
# =====================================================================
# Several melodies to train on (MIDI note numbers)

corpus = {
  # Twinkle Twinkle Little Star
  twinkle: [60,60,67,67,69,69,67, 65,65,64,64,62,62,60,
            67,67,65,65,64,64,62, 67,67,65,65,64,64,62,
            60,60,67,67,69,69,67, 65,65,64,64,62,62,60],

  # Ode to Joy
  ode_to_joy: [64,64,65,67,67,65,64,62,60,60,62,64,64,62,62,
               64,64,65,67,67,65,64,62,60,60,62,64,62,60,60],

  # Frere Jacques
  frere: [60,62,64,60,60,62,64,60,64,65,67,64,65,67,
          67,69,67,65,64,60,67,69,67,65,64,60,60,55,60,60,55,60],
}

# =====================================================================
# Part 2: Build an nth-order Markov model
# =====================================================================
# Returns a Hash mapping context strings to arrays of possible next notes

define :build_markov do |melody, order|
  model = {}
  (melody.length - order).times do |i|
    context = melody[i, order].to_s   # Use string key for array lookup
    nxt = melody[i + order]
    model[context] = [] unless model.include?(context)
    model[context].push(nxt)
  end
  model
end

# =====================================================================
# Part 3: Generate from a Markov model
# =====================================================================
# Seeds with the first n notes, then generates the rest

define :generate_markov do |model, melody, order, length|
  output = melody[0, order].dup   # Seed with first n notes
  (length - order).times do
    context = output.last(order).to_s
    choices = model[context]
    if choices != nil
      output.push(choices.choose)
    else
      # Fallback: random note from corpus
      output.push(melody.choose)
    end
  end
  output
end

# =====================================================================
# Part 4: Compare different orders
# =====================================================================

define :compare_orders do |melody, name|
  puts "Training on: #{name} (#{melody.length} notes)"
  puts ""
  (0..5).each do |order|
    if order == 0
      # Order 0: uniform random from corpus notes
      generated = Array.new(32) { melody.choose }
      puts "Order 0 (random): #{generated}"
    else
      model = build_markov(melody, order)
      generated = generate_markov(model, melody, order, 32)
      puts "Order #{order}: #{generated} (#{model.length} unique contexts)"
    end
  end
end

compare_orders(corpus[:twinkle], "Twinkle")

# =====================================================================
# Part 5: Play original vs. generated
# =====================================================================

source = corpus[:twinkle]
order = 2
model = build_markov(source, order)
generated = generate_markov(model, source, order, 32)

# Play original then generated
live_loop :original do
  use_synth :piano
  source.each do |n|
    play n, amp: 0.4, sustain: 0.15, release: 0.05
    sleep 0.25
  end
  sleep 1
  stop
end

sleep source.length * 0.25 + 1

live_loop :generated_melody do
  use_synth :piano
  generated.each do |n|
    play n, amp: 0.4, sustain: 0.15, release: 0.05
    sleep 0.25
  end
  stop
end

sleep generated.length * 0.25 + 1

# =====================================================================
# Part 6: Continuous Markov generation (live_loop)
# =====================================================================
# Real-time generation — the model generates notes on the fly

order2 = 2
model2 = build_markov(corpus[:twinkle], order2)
context_buf = corpus[:twinkle][0, order2].dup

live_loop :live_markov do
  use_synth :piano
  key = context_buf.to_s
  choices = model2[key]
  nxt = (choices != nil) ? choices.choose : corpus[:twinkle].choose
  context_buf.shift
  context_buf.push(nxt)
  play nxt, amp: 0.4, sustain: 0.15, release: 0.05
  sleep 0.25
end

sleep 16  # Let it run for a while
stop

# =====================================================================
# Part 7: Train on combined corpus
# =====================================================================

combined = corpus[:twinkle] + corpus[:ode_to_joy] + corpus[:frere]
order3 = 2
model3 = build_markov(combined, order3)
generated3 = generate_markov(model3, combined, order3, 64)

live_loop :combined_markov do
  use_synth :piano
  generated3.each do |n|
    play n, amp: 0.4, sustain: 0.15, release: 0.05
    sleep 0.25
  end
  stop
end

# --- Experiment ---
# 1. How does order affect the output? Listen to orders 1-5.
# 2. What happens when you train on a very short vs. very long melody?
# 3. Combine multiple melodies — does the model blend styles?
# 4. Add rhythm: build a separate Markov model for durations
# 5. Can you tell the difference between order 3 and the original?
