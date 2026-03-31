# Prof. Michael A. Casey
# Dartmouth College, Department of Music, Department of Computer Science
# Course: Music and AI, 2023. Language: Sonic PI / Ruby
use_random_seed 2

define :do_init do
  use_bpm 100
  set :note_set, [0,1,2,4,5,:r,7]
  set :hits1, 2*rrand_i(3,7)-1 # odd number, likely prime
  set :quanta, 16
  notes = get[:note_set].pick(get[:hits1])
  set :mel1, notes.reverse.take(notes.length-1).push([0,0,2].choose).reverse()
  set :onsets1, spread(get[:hits1], get[:quanta], rotate: rrand_i(0,get[:quanta]))
  set :sc, scale(:a, :hex_aeolian, num_octaves: 3)
  set :tick_dur, 0.25
  set :hits2, 2*rrand_i(3,7)-1 # odd number, likely prime
  set :mel2, get[:note_set].pick(get[:hits1])
  set :onsets2, spread(get[:hits1], get[:quanta], rotate: rrand_i(0,get[:quanta]))
  puts get[:mel1],get[:mel2],get[:onsets],get[:onsets2]
end

do_init

live_loop :foo do
  sleep get[:tick_dur]
end

live_loop :melody do
  sync :foo
  si = [0,1,2].choose
  use_synth [:dpulse, :kalimba, :piano][si]
  a = [0.025,0.9,0.15][si]
  rel = rrand(1,4) * get[:tick_dur]
  divexp = rrand_i(0,2)
  with_fx :echo, phase: rrand_i(1,16) * 0.5, mix: rrand(0.25,0.8), decay: rrand(1,10), reps: 4 do
    with_fx :reverb, room: rrand(0,1), reps: 4 do
      4.times do
        if get[:onsets1].tick
          m = get[:mel1].look
          play (m==:r) ? (:r) : (get[:sc][m]), amp: a, attack: 0, release: rel
        end
        sleep get[:tick_dur] * (2 ** divexp)
      end
    end
  end
end

live_loop :bass do
  with_fx :echo, phase: rrand_i(0,64)*0.25, decay: rrand(0.1,4), reps: 16 do
    sync :foo
    use_synth :bass_foundation #:tb303
    oct = 3 # [2,3].choose
    rel = rrand(0.25,2) * get[:tick_dur]
    divexp = rrand_i(0,0)
    4.times do
      if get[:onsets2].tick and [0,1].choose
        m = get[:mel1].look
        play (m==:r) ? (:r) : (get[:sc][7-m])-(oct*12), amp: 0.125, lpf: rrand(100,500), release: rel
      end
      sleep get[:tick_dur] * (2 ** divexp)
    end
  end
end

live_loop :bd do
  sync :foo
  if get[:onsets1].tick
    sample :drum_bass_soft, lpf: rrand(90,110), amp: 0.5, rate: 2.0, attack: 0, decay: 0.1, release: 0.01
  end
  sleep get[:tick_dur] # * [4,5,7,11].choose
end

live_loop :sn do
  sync :foo
  #stop
  with_fx :reverb, reps: 16 do
    if get[:onsets2].tick
      sample :drum_snare_hard, lpf: rrand(50,100), amp: 0.25, rate: rrand(1.0,3.0)
    end
    sleep get[:tick_dur] # * [2,3,4,5,11].tick
  end
end

live_loop :hh do
  sync :foo
  #stop
  divexp = rrand_i(0,0)
  with_fx :reverb, reps: 16 do
    sample :drum_cymbal_closed, lpf: rrand(40,127), amp: 0.33, rate: rrand(1.0,3.0)
    sleep get[:tick_dur] * (2 ** divexp)
  end
end

live_loop :hho do
  sync :foo
  #stop
  divexp = rrand_i(0,0)
  with_fx :reverb, reps: 16 do
    if rrand(0,1)<0.125
      sample :drum_cymbal_open, lpf: rrand(40,127), amp: 0.33, rate: rrand(1.0,3.0)
    end
    sleep get[:tick_dur] * (2 ** divexp)
  end
end

live_loop :init do
  do_init
  sleep get[:tick_dur]*16*16
end

