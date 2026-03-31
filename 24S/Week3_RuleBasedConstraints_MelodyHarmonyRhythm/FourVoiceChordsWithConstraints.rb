# Prof. Michael A. Casey
# Dartmouth College, Department of Music, Department of Computer Science
# Course: Music and AI, 2023. Language: Sonic PI / Ruby
# Assignment 3, auto-voiced chord sequences avoiding parallel 5ths and 8ves
# Prof. Michael Casey, Darmtouth College, Department of Computer Science
# Root position chords made from scale degrees (like Roman numerals)
# uses the .values_at method and *splat: scl.values_at(*(degrees + offset))

def has_parallels a, b
  if (a<=>b) != 0 # repeated-chord parallels are OK
    (0..a.length-2).each do |i| # each voice in chord
      ((i+1)..b.length-1).each do |j| # to each-other voice in chord
        if (a[j]-a[i]==4 && b[j]-b[i]==4) || (a[j]-a[i]==7 && b[j]-b[i]==7)
          return true
        end
      end
    end
  end
  return false
end

use_random_seed beat
use_bpm 60
sequence = [0,4,5,2,3,0,3,4]*4 # root-position chords (degrees) to be realized
scl = scale(:d4, :major, num_octaves: 2) # use this scale (2 octaves)
##| sequence = [7,4,5,6] # root-position chords (degrees) to be realized
##| scl = scale(:g3, :minor, num_octaves: 2) # use this scale (2 octaves)

use_synth :piano # use this synth, with the following synth defaults
use_synth_defaults amp: 0.25, sustain_level: 0.8, release: 2
chord_pat = [0,2,4,7].ring # (chord pattern scale degrees)
rhythm_pat = [0.25]*4

with_fx :gverb, room: 100, release: 2, mix: 0.333 do
  live_loop :realization do
    last_chord = chord_pat + sequence[-1] # previous chord
    sequence.each do |deg| # convert scale degrees to chords, 0=I, 1=ii, 2=iii,...
      current_chord = chord_pat + deg  # add current scale-degree (+ deg)
      while has_parallels last_chord, current_chord
        idx = rand_i(3)+1 # choose one of the voices to alter
        arr = current_chord.to_a # make a mutable auxilliary Array
        arr[idx] = (arr[idx] + 7) % 21 # alter the voice (by an octave)
        current_chord = arr.sort.ring # assign as the current-chord ring
      end
      rhythm = rand<0.25 ? rhythm_pat.shuffle : rhythm_pat
      play scl.values_at(*current_chord)-24, attack: 0.05, sustain_level: 0.9, release: 1, amp: 0.7 # sustained chord, low
      play_pattern_timed scl.values_at(*current_chord), rhythm, amp: 0.3 # melody pattern
      last_chord = current_chord
    end
  end
end

