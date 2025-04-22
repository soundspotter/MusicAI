# Prof. Michael A. Casey
# Dartmouth College, Department of Music, Department of Computer Science
# Course: Music and AI, 2023. Language: Sonic PI / Ruby
# isorhythmic MIDI melody and bass generation
# Everything is deterministic
# Seed the psuedo-random number generator (p-RNG)
use_random_seed beat

# Work with relative melodic pitch-rhythm cells
M = rrand_i(4,11)
N = rrand_i(4,11)
melody = (0..13).take(M).ring
melody = rrand(0,1)<0.5 ? melody.shuffle : melody
scl = scale(:fs3, :lydian, num_octaves: 3)
rhythm = [0.25, 0.25, 0.5,0.25,0.25,0.5,1].take(N).ring
rhythm = rhythm.shuffle
puts M, N
puts melody, rhythm

live_loop :mel do
  note = scl[melody.tick] + 12
  midi_note_on note, rrand_i(50,100), channel: 1
  set :isPaused, rrand(0,1)<0.25 ? true : false
  if get[:isPaused]
    set :pauseDur, [0.25,0.5,0.5,0.5].choose
    sleep get[:pauseDur]
  else
    sleep rhythm.look
  end
  midi_note_off note
end

live_loop :bass do
  note = 100 - scl[melody.tick]
  midi_note_on note, rrand_i(50,100), channel: 2
  if get[:isPaused]
    sleep get[:pauseDur] # Keep melody and bass in sync
  else
    sleep rhythm.look
  end
  midi_note_off note
end
