# Synthesis I
# Drone Music
# Michael Casey


define :update do
  set :co_max, 120
  set :co_min, 40
  set :amp1, 0.125
  set :amp2, 0.0625
  set :div1, 32
  set :div2, 512
  set :dur, 32.0
  set :co1, (line get[:co_max], get[:co_min], steps: get[:div1]/2, inclusive: true).mirror
  set :co2, (line get[:co_min], get[:co_max], steps: get[:div2]/2, inclusive: true).mirror
  set :slc_ph1, 0.03125
  set :slc_wv1, 2
  set :phase, [0.5,1,2,4,8].choose
end

update

live_loop :foo do
  with_fx :slicer do |slc|
    sync :foo
    (get[:dur]*get[:div1]).times do
      control slc, phase: get[:slc_ph1], wave: get[:slc_wv1]
      use_synth :bass_foundation
      use_synth_defaults attack: 2.5, decay: 2.5, sustain: 0.5, release: 1.0, amp: get[:amp1]
      play 36, cutoff: get[:co1][look], pan: -1
      play 24, cutoff: get[:co_max] - get[:co1][look] + get[:co_min], pan: 1
      play 43, cutoff: get[:co1][look + get[:div1]/2], pan: 0.05
      sleep get[:dur]/get[:div1]
      tick
    end
  end
end

with_fx :reverb, room: 0.95, mix: 0.8 do
  live_loop :bar do
    sync :foo
    (get[:dur]*get[:div2]).times do
      use_synth [:bass_foundation, :saw].choose
      use_synth_defaults attack: 0.005, decay: 0.01, sustain: 0.05, release: 0.05, amp: get[:amp2]
      play [43, 72, 55, 67, 70].choose, cutoff: get[:co2][look]+rrand(-10,10), pan: -1
      play [43, 55, 84, 67, 74].choose, cutoff: get[:co_max] - get[:co2][look] + get[:co_min] + rrand(-10,10), pan: 1
      play [43, 55, 67, 79].choose, cutoff: get[:co2][look + get[:div2]/2] + rrand(-10,10), pan: 0.05
      tick
      sleep get[:dur]/get[:div2]
    end
  end
end

live_loop :maestro do
  cue :foo
  sleep get[:dur]
end







