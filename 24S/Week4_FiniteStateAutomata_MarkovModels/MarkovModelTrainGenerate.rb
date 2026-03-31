# Prof. Michael A. Casey
# Dartmouth College, Department of Music, Department of Computer Science
# Course: Music and AI, 2023. Language: Sonic PI / Ruby
# Simple input melody represented as a list of MIDI note numbers
input_melody = [60, 64, 67, 72, 67, 64, 60, 55, 60, 64, 67, 72]

# Build a Markov model from the input melody
define :build_markov_model do |input_melody|
  model = {}
  (input_melody.length - 1).times do |i|
    context = input_melody[i]
    next_note = input_melody[i + 1]
    if model.include? context
      model[context].append(next_note)
    else
      model[context] = [next_note]
    end
  end
  model
end

# Generate a new melody using the Markov model
define :generate_melody do |model, start_note, length|
  melody = [start_note]
  next_note = melody[-1] # the start note is the last note so far
  (length - 1).times do
    context = next_note # the last generated melody note
    if model.include? context
      next_note = model[context].choose
      melody.append(next_note)
    else
      break
    end
  end
  melody
end

# Build a Markov model of order 1
markov_model = build_markov_model(input_melody)

puts markov_model

# Generate a new melody starting with the note 'C4' (MIDI note 60) and 12 notes long
new_melody = generate_melody(markov_model, 60, 24)

# Play the old melody
input_melody.each do |note|
  play note
  sleep 0.5
end

sleep 2

# Play the new melody
new_melody.each do |note|
  play note
  sleep 0.5
end
