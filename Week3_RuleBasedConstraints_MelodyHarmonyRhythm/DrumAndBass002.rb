use_synth :dtri
use_synth_defaults release: 2, attack: 0.01



use_bpm 60
use_random_seed 101

s = nil

song = [69,67,65,69,69,67,65,69,72,75,72,70,72,75,72,70]

use_synth :bass_foundation
s = nil

sync "/live_loop/hh"

live_loop :loop2 do
  use_octave -2
  s = play song.tick, cutoff: 85,  amp: 0.5, attack: 0, decay_time: 0, sustain: 4, release: 0.25
  sleep 4
end

live_loop :loop3 do
  control s, cutoff: rrand_i(70,100)
  sleep 0.25
end

