define :update do
  set :co_max, 120
  set :co_min, 40
  set :amp1, 0.125
  set :amp2, 0.0625
  set :div1, 16
  set :div2, 128
  set :dur, 8.0
  set :co1, (line get[:co_max], get[:co_min], steps: get[:div1]/2, inclusive: true).mirror
  set :co2, (line get[:co_min], get[:co_max], steps: get[:div2]/2, inclusive: true).mirror
  set :slc_ph1, 0.03125
  set :slc_wv1, 2
  set :phase, [0.5,1,2,4,8,16].choose
end


live_loop :bd do
  sync :bar
  #stop
  (get[:div1]).times do
    synth :sc808_bassdrum, note: [48, 48, 36, 40].look, release: 1.0, sustain_level: 0.9
    sleep [0.5,0.5,1].choose
    tick
  end
end

live_loop :sn do
  sync :bar
  with_fx :slicer, phase: [0.0625, 0.125, 0.25, 0.5].choose, wave: 2 do
    with_fx :echo, phase: [0.0625, 0.125, 0.125, 0.25, 0.5].choose, mix: 0.5 do
      with_fx :flanger, mix: 0.25 do
        with_fx :wobble, phase: get[:phase], cutoff_max: 120, cutoff_min: 70, filter: 0, res: 0.7, wave: 2 do
          with_fx :reverb, room: 0.9, mix: 0.75 do
            (get[:div1]).times do
              synth :sc808_snare, note: rrand_i(12,36), amp: rrand(0.05,0.2), attack: rrand_i(0.1, 1.5), release: rrand_i(0.125, 1)
              sleep [0.5,0.25,0.25,0.25,0.25,0.25,0.25,0.5,0.5,0.25,0.25,0.125,0.125,0.125,0.125].look
              tick
            end
          end
        end
      end
    end
  end
end

live_loop :timing do
  update
  cue :bar
  sleep 4
end









