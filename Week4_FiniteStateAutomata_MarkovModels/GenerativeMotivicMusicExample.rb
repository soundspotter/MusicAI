# Prof. Michael A. Casey
# Dartmouth College, Department of Music, Department of Computer Science
# Course: Music and AI, 2023. Language: Sonic PI / Ruby
# Generative Motivic Music - melody plus bass as inverse of melody
#
# Michael A. Casey
# Dartmouth College, Department of Music, Department of Computer Science
# Course: Music and AI, 2023W. Language: Sonic PI / Ruby
#
# :generate_variation - parametric initialization of global timed variables,
#   -make a random variation of the musical parameters.
#
# The generated 8-bars will loop continuously until generate_variation is called again.
# We place generate_variation in a live_loop and call it every 8 bars.
#
# Outputs audio corresponding to:
#   melody - pitch list [length N] - start on tonic or 3rd constraint
#     onsets1 - onset list [length M>N], Euclidean N,M
#   bass - pitch list, [inverse of melody, length N2]
#     onsets2 - bass onset list [length M2>N2], Euclidean N2,M2 suppressed p=0.5
#   percussion - bd follows onsets1, sn follows onsets2, hh rate: and lpf: cutoff are rrand modulated
#
#  Percussion tracks switch themselves on and off with 50% probability every 8 bars

use_random_seed 101  # Change value for different patterns: e.g. 127, 110701, ...
use_bpm 90 # change the speed

define :generate_variation do
  set :tick_dur, 0.25 # normative (bpm=60) tick duration
  set :time_sig, [4,4] # numerator / denominator of time signature
  set :quanta, [16,32].choose  # duration of melody in ticks, usually a power of 2 (8,16,32)
  set :phrase_length, 128
  set :melody_timbres, [:dpulse, :kalimba, :piano] # choice of melody sounds
  set :melody_timbres_balance, [0.1,0.95,0.2] # relative amp: of timbres
  set :bass_timbres, [:tb303, :bass_foundation] # choice of bass sounds
  set :bass_timbres_balance, [0.125, 0.3] # relative amp: of bass sounds
  set :sc, scale(:e0, :aeolian, num_octaves: 7) # the scale to use
  set :chords, [0,0,3,4].pick([1,2,4].choose) # chord sequence for the melody, 0-based scale degrees
  set :note_set, [0,1,2,4,5,:r,7] # restricted set of scale degrees
  set :hits1, 2*rrand_i(3,get[:quanta]/2-1)-1 # odd number, likely prime
  set :notes, get[:note_set].pick(get[:hits1]) # grab pitches and rests (:r)
  # constrain notes to begin on the first or third scale degrees (0 or 2)
  set :mel1, get[:notes].reverse.take(get[:notes].length-1).push([0,0,2].choose).reverse()
  set :onsets1, spread(get[:hits1], get[:quanta]) #, rotate: rrand_i(0,get[:quanta]/4)) # Euclidean rhythm
  set :hits2, 2*rrand_i(3,get[:quanta]/2) # even number
  set :mel2, get[:note_set].pick(get[:hits2]) # alternate melody, for variation
  set :onsets2, spread(get[:hits2], get[:quanta]) #, rotate: rrand_i(0,get[:quanta]/4)) # Euclidean rhythm
  puts get[:mel1].length, get[:mel1]
  puts get[:onsets1].to_a.count(true), get[:onsets1]
  puts get[:mel2].length, get[:mel2]
  puts get[:onsets2].to_a.count(true), get[:onsets2]
  puts get[:chords]
end

generate_variation # create initial values for music variables

live_loop :melody do # the tune, based on repeating a pitch motif over a duration set (isorhythm)
  i = rrand_i(0,get[:melody_timbres].length-1) # index of synth to use, for amp scaling
  use_synth get[:melody_timbres][i]
  amp = get[:melody_timbres_balance][i]
  rel = rrand(1,4) * get[:tick_dur]
  oct = 4 # which octave to center melody
  on = true
  c = 0 # chord degree, controlled by contents of get[:chords]
  with_fx :reverb, room: rrand(0.25,0.9),damp: rrand(0.25,0.7), mix: rrand(0.5,0.6) do
    with_fx :echo, phase: rrand_i(1,16) * 0.25, mix: rrand(0.5,0.8), decay: rrand(3,8), reps: get[:phrase_length] do
      tick
      if (look)%((get[:phrase_length]/2)/get[:chords].length)==0
        puts "melody", look
        c = get[:chords].tick(:chord)
        puts "chord", look(:chord)
        puts c
      end
      if on and get[:onsets1].look
        m = get[:mel1].tick(:mel)
        play (m==:r) ? (:r) : (get[:sc][m+c+oct*7]), amp: amp, attack: 0, release: rel
      end
      sleep get[:tick_dur]
    end
  end
end


live_loop :bass do # bass track (inverse of melody, different Euclidean rhythm and thinning)
  idx = [0,1].choose # index of synth to use, for amp scaling
  use_synth get[:bass_timbres][idx]
  amp = get[:bass_timbres_balance][idx]
  oct = 2 # bass octave adjust (down)
  rel = rrand(1,2.5) * get[:tick_dur]
  on = true # [true,false].choose # leave on!
  c = 0 # chord degree, controlled by contents of get[:chords]
  get[:phrase_length].times do
    tick
    if (look)%((get[:phrase_length]/2)/get[:chords].length)==0
      c = get[:chords].tick(:chords)
    end
    if on and get[:onsets2].look # and [0,1].choose # bass thinning
      m = get[:mel1].tick(:mel) # use inversion, -m (line below)
      play (m==:r) ? (:r) : get[:sc][-m+c+oct*7], amp: amp, cutoff: rrand(50,100), release: rel
    end
    sleep get[:tick_dur]
  end
end

live_loop :bd do # bass drum
  on = true # [true,false].choose # 50% probability every 8 bars
  get[:phrase_length].times do
    tick
    if on and get[:onsets2].look
      sample :drum_bass_soft, lpf: rrand(60,100), amp: 0.25, rate: 2, release: 0.1
    end
    sleep get[:tick_dur] # * [4,5,7,11].choose
  end
end

live_loop :sn do # snare
  on = true # [true,false].choose
  with_fx :reverb, reps: get[:phrase_length] do # 50% probability every 8 bars
    tick
    if on and get[:onsets1].look
      sample :drum_snare_hard, lpf: rrand(60,110), amp: 0.25, rate: rrand(1.0,3.0)
    end
    sleep get[:tick_dur]
  end
end

live_loop :hh do # hi-hat closed
  on = [true,false].choose # 50% probability every 8 bars
  with_fx :reverb, room: 0.75, mix: 0.6, reps: get[:phrase_length] do
    tick
    if on
      sample :drum_cymbal_closed, lpf: rrand(40,127), amp: 0.33, rate: rrand(1.0,3.0)
    end
    sleep get[:tick_dur]
  end
end

live_loop :hho do # hi-hat open
  on = [true,false].choose # 50% probability every 8 bars
  with_fx :reverb, room: 0.75, mix: 0.6, reps: get[:phrase_length] do
    tick
    if on and ((look%32<4) or ((look-1)%64>48)) and rrand(0,1)<0.5 # open hh every 4 bars
      sample :drum_cymbal_open, lpf: rrand(50,127), amp: 0.4, rate: rrand(1.0,3.0)
    end
    if on and look%64==0
      sample :drum_cymbal_soft, lpf: rrand(80,120), amp: 1.0, rate: rrand(1.0,2.0), release: 10
    end
    sleep get[:tick_dur]
  end
end

live_loop :foo do # a closed hi-hat pulse, 50% on/off every 8 bars
  on = [true,false].choose
  amp = rrand(0.05,0.2)
  with_fx :echo, phase: rrand_i(1,4) * 0.25, mix: rrand(0.4,0.6), decay: rrand(3,6), reps: get[:phrase_length] do
    tick
    if on and look%4==0
      sample :drum_cymbal_closed, amp: amp
    end
    sleep get[:tick_dur]
  end
  generate_variation # Make a new variation every 16 ticks * 8 bars
end

