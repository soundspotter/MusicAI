# Prof. Michael A. Casey
# Dartmouth College, Department of Music, Department of Computer Science
# Course: Music and AI, 2023. Language: Sonic PI / Ruby
# Generative Motivic Music - melody plus bass as inverse of melody
#
# Michael A. Casey
# Dartmouth College, Department of Music,
# Department of Computer Science
# Language: Sonic PI / Ruby

# :generate_variation - parametric initialization of global timed variables
# Makes a random variation of musical parameters
# Music will loop until do_init is called again
#
# Parameters:
# mel1 - [p1,p2,...,pN] - pitch list, used for melody and bass [chooses N,N2 pentatonic degrees + rest]
# [mel2] - [q1,q2,...,qN2] - alternate pitch list, variation or bass [inverse of mel1]
# onsets1 - Euclidean rhythm (N=6..13,M=16)
# onsets2 - Euclidean rhythm (N2=4..11,M2=16)
# melody_timbres - [:dpulse, :kalimba, :piano] - chooses from these
# melody_timbres_balance - :amp values for timbres [0.05, 0.9, 0.2]
# bass_timbres - [:bass_foundation, :tb303]
# bass_timbres_balance - [0.125,0.333]
# percussion_timbres - [[bd1,bd2],[sn1,sn2,sn3],[hc1,hc2,hc3],[ho1,ho2]]
# percussion_timbres_balance - [0.5,0.5,0.5,0.5]
#
# outputs audio corresponding to:
#   melody - pitch list [length N] - start on tonic or 3rd constraint
#     onsets1 - onset list [length M>N], Euclidean N,M
#   bass - pitch list, [inverse of melody, length N2]
#     onsets2 - bass onset list [length M2>N2], Euclidean N2,M2 supressed p=0.5
#   percussion - bd follows onsets1, sn follows onsets2, hh rrand modulated

use_random_seed 101
use_bpm 100

define :generate_variation do
  set :tick_dur, 0.25 # normative (bpm=60) tick duration
  set :quanta, 16  # ticks per bar, even number, likely power of 2
  set :melody_timbres, [:dpulse, :kalimba, :piano] # choice of melody sounds
  set :melody_timbres_balance, [0.025,0.9,0.15] # relative amp: of timbres
  set :bass_timbres, [:tb303, :bass_foundation] # choice of bass sounds
  set :bass_timbres_balance, [0.125, 0.333] # relative amp: of bass sounds
  set :sc, scale(:D4, :aeolian, num_octaves: 3) # the scale to use
  set :note_set, [0,1,2,4,5,:r,7] # restricted set of scale degrees
  set :hits1, 2*rrand_i(3,get[:quanta]/2-1)-1 # odd number, likely prime
  notes = get[:note_set].pick(get[:hits1]) # start pitch on tonic or 3rd
  set :mel1, notes.reverse.take(notes.length-1).push([0,0,2].choose).reverse()
  set :onsets1, spread(get[:hits1], get[:quanta]) #, rotate: rrand_i(0,get[:quanta]/4)) #
  set :hits2, 2*rrand_i(2,get[:quanta]/2-1)-1 # odd number, likely prime
  set :mel2, get[:note_set].pick(get[:hits2]) # alternate melody, for variation
  set :onsets2, spread(get[:hits2], get[:quanta]) # rotate: ?
  puts get[:mel1]
  puts get[:onsets1]
  puts get[:mel2]
  puts get[:onsets2]
end

# Live loops:
live_loop :new_variation do # Variation generator
  generate_variation() # Make a new variation every 16 ticks * 8 bars
  sleep get[:tick_dur] * 16 * 8
end

live_loop :foo do
  sleep get[:tick_dur]
end

live_loop :melody do
  sync :foo
  i = rrand_i(0,get[:melody_timbres].length-1) # index of synth to use, for amp scaling
  use_synth get[:melody_timbres][i]
  amp = get[:melody_timbres_balance][i]
  rel = rrand(1,4) * get[:tick_dur]
  on = true # [true,false].choose
  with_fx :echo, phase: rrand_i(1,16) * 0.5, mix: rrand(0.25,0.8), decay: rrand(1,10), reps: 8 do
    with_fx :reverb, room: rrand(0,1), reps: 16 do
      if on and get[:onsets1].tick
        m = get[:mel1].look
        play (m==:r) ? (:r) : (get[:sc][m]), amp: amp, attack: 0, release: rel
      end
      sleep get[:tick_dur]
    end
  end
end

live_loop :bass do
  #  with_fx :echo, phase: rrand_i(0,64)*0.25, decay: rrand(0.1,4), reps: 16 do
  sync :foo
  i = rrand_i(0,get[:bass_timbres].length-1) # index of synth to use, for amp scaling
  use_synth get[:bass_timbres][i]
  amp = get[:bass_timbres_balance][i]
  oct = 3 # [2,3].choose
  rel = rrand(0.25,2) * get[:tick_dur]
  on = true # [true,false].choose
  8.times do
    16.times do
      if on and get[:onsets2].tick and [0,1].choose
        m = get[:mel1].look # use inversion, 7-m (line below)
        play (m==:r) ? (:r) : (get[:sc][7-m])-(oct*12), amp: amp, cutoff: rrand(30,90), release: rel
      end
      sleep get[:tick_dur]
    end
  end
  #  end
end

live_loop :bd do
  sync :foo
  on = [true,false].choose
  (8*16).times do
    if on and get[:onsets1].tick
      sample :drum_bass_soft, lpf: rrand(90,120), amp: 0.5, rate: 2
    end
    sleep get[:tick_dur] # * [4,5,7,11].choose
  end
end


live_loop :sn do
  sync :foo
  on = [true,false].choose
  with_fx :reverb, reps: 8*16 do
    if on and get[:onsets2].tick
      sample :drum_snare_hard, lpf: rrand(50,100), amp: 0.25, rate: rrand(1.0,3.0)
    end
    sleep get[:tick_dur] # * [2,3,4,5,11].tick
  end
end

live_loop :hh do
  sync :foo
  on = [true,false].choose
  with_fx :reverb, reps: 8*16 do
    if on
      sample :drum_cymbal_closed, lpf: rrand(40,127), amp: 0.33, rate: rrand(1.0,3.0)
    end
    sleep get[:tick_dur]
  end
end

live_loop :hho do
  sync :foo
  on = [true,false].choose
  with_fx :reverb, reps: 8*16 do
    tick(:counter)
    if on and ((look(:counter)%32<4) or (look(:counter)%64>48)) and rrand(0,1)<0.5 # open hh every 4 bars
      sample :drum_cymbal_open, lpf: rrand(40,127), amp: 0.33, rate: rrand(1.0,3.0)
    end
    if on and look(:counter) % 64 == 0
      sample :drum_cymbal_soft, lpf: rrand(80,120), amp: 1.0, rate: rrand(1.0,2.0), release: 10
    end
    sleep get[:tick_dur]
  end
end

##| with_fx :reverb, room: 1 do
##|   live_audio :foo
##| end

##| live_loop :melody do
##|   stop
##| end

##| live_loop :bass do
##|   stop
##| end

##| live_loop :bd do
##|   stop
##| end

##| live_loop :sn do
##|   stop
##| end

##| live_loop :hh do
##|   stop
##| end

##| live_loop :hho do
##|   stop
##| end

