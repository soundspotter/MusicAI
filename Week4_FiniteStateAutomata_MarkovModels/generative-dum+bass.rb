@REPS = 64
use_bpm 76
use_random_seed 1001

def badass
  return [:bd_sone, :bd_gas, :bd_boom, :bd_808, :bd_fat].choose
end

b1 = [7,5,7,5,3,4].ring
bass = b1 + (b1+1) + (b1+2)

scl = scale(:d1, :acem_asiran, num_octaves: 3)

live_loop :bass do
  with_fx :echo, phase: 0.5, decay: 2, reps: @REPS do
    use_synth :bass_foundation
    if spread(11,32).tick
      play scl [bass.look ], amp: 0.5, release: rrand(0.1, 0.5)
    end
    sleep 0.25
  end
end

live_loop :chrds do
  use_synth :kalimba
  if spread(17, 32).tick
    play scl [ bass.tick] + 36, amp: 1.0, attack: 0.001, sustain_level: 1.0, release: 0.1
    play scl [ bass.tick] + 24, amp: 1.0, attack: 0.001, sustain_level: 1.0, release: 0.1
    play scl [ bass.tick] + 48, amp: 1.0, attack: 0.001, sustain_level: 1.0, release: 0.1
  end
  sleep 0.5
end


live_loop :l1 do
  if tick % 4 == 3 # check for fill
    sample badass
    sleep 0.125
    sample badass
    sleep 0.125
  else
    sample :bd_boom
    sleep 0.5
  end
end

live_loop :l2 do
  sleep 1.75
  sample :drum_cymbal_pedal, amp: 0.1
  sleep 0.25
end

live_loop :l3 do
  with_fx :reverb, mix: 0.7, reps: @REPS do
    sample :drum_cymbal_closed, amp: 0.25, attack: rrand(0.01, 0.1), release: rrand(0.1, 0.9)
    sleep 0.125
  end
end

live_loop :l4 do
  with_fx :reverb, mix: 0.2, reps: @REPS do
    if spread(23,32, rotate:3).tick
      sample :drum_cymbal_closed, amp: 0.1
    end
    sleep 0.25
  end
end



