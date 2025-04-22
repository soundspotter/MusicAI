# Prof. Michael A. Casey
# Dartmouth College, Department of Music, Department of Computer Science
# Course: Music and AI, 2023. Language: Sonic PI / Ruby
# Brian Eno's Discreet Music

use_bpm 40

p1 = [:Db4,:Eb4, :rest, :F3, :rest, :Ab3, :rest, :F4, :Ab4, :Bb4, :Ab4, :rest]
r1 = [1, 3, 4, 4, 4, 4, 4, 1, 1, 1, 2, 3]

p2 = [:Eb4, :F4, :rest, :C4, :Ab3, :rest, :Eb3, :rest, :Ab3, :rest]
r2 = [2, 3, 3, 1, 3, 4, 4, 4, 4, 4]

with_fx :reverb, room: 0.95, mix: 0.9, damp: 0.1 do
  with_fx :echo, max_phase: 10, phase: 10, decay: 60 do
    
    use_synth :tri
    
    live_loop :loop1 do
      use_octave 1
      play p1.tick, pan: -1, amp: 0.2, attack: rrand(0.25,0.75), release: 4, cutoff: 70
      sleep r1.look
    end
    
    use_synth :dpulse
    
    use_bpm_mul 63.5/68.7 # The speed difference between the two equal-length loops
    
    at rrand(10,20) do
      use_octave 1
      live_loop :loop2 do
        play p2.tick, pan: 1, amp: 0.2, attack: rrand(0.25,0.75), release: 4, cutoff: 70
        sleep r2.look
      end
    end
  end
end

live_loop :drone do
  use_synth :bass_foundation
  play :Db1, sustain: 30, cutoff: 70, amp: 0.75
  play :Db2, sustain: 30, cutoff: 70, amp: 0.5
  play :Ab2, sustain: 30, cutoff: 70, amp: 0.25
  sleep 30
end


