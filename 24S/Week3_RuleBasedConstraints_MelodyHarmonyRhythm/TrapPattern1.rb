use_bpm 70
#
live_loop :bd do
  sample :drum_bass_soft
  sleep [1,2,1,1,2,3].choose
end

live_loop :sn do
  sleep 1
  sample :drum_snare_hard, rate: [2,1.25,1.75,2.25,1.5].choose
  sleep 1
end

# Those all important hats
def hat(v)
  sample :drum_cymbal_closed, amp: 1.5*v, attack: 0, decay: 0.01, sustain: 0, release: 0
end

live_loop :hats do
  a = [0,0,0,1,1,2,2,2,2].choose
  case a
  when 0
    8.times do
      hat(1)
      sleep 0.25
    end
  when 1
    8.times do
      hat(1)
      sleep 0.125
    end
  when 2
    2.times do
      hat(1)
      sleep 0.15
      hat(1)
      sleep 0.15
      hat(1)
      sleep 0.2
    end
  end
end