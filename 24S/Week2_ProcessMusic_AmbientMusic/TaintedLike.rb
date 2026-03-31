use_bpm 70

live_loop :bd do
  sample :drum_bass_hard, rate: 2, amp: 0.1
  sleep 1
end

with_fx :reverb, room: 0.5, mix: 0.5 do
  live_loop :sinwave do
    16.times do |i|
      if(i%3==0)
        a=0.2
      else
        a=0.1
      end
      play [72,36,24].choose, amp: a, attack: 0.005, sustain: 0.05, release: 0.15
      sleep 0.25
    end
  end
end

with_fx :reverb, room: 0.7, mix: 0.75 do
  live_loop :sn do
    sleep 1
    sample :drum_snare_hard, amp: rrand(0.25,0.67), rate: rrand(2.75,2.0)
    sleep 1
  end
end
