# Steve Reich's Piano Phase
# See: https://en.wikipedia.org/wiki/Piano_Phase

# use_synth :piano
notes = (ring :E4, :Fs4, :B4, :Cs5, :D5, :Fs4, :E4, :Cs5, :B4, :Fs4, :D5, :Cs5)

use_bpm 140

use_synth :piano
with_fx :reverb, mix: 0.75, room: 0.75, damp: 0.9 do
  live_loop :slow do
    play notes.tick, release: 0.2
    sleep 0.3
  end
end

live_loop :faster do
  play notes.tick, release: 0.2
  sleep 0.295
end

