# W. A. Mozart Musikalisches Würfelspiel (K. 294dK3 or K. 516fK6)
# published in 1792, by Mozart's publisher Nikolaus Simrock in Berlin
#
# Michael Casey
# Music and AI
# Dartmouth College, CS Dept., 24S

MozartDir = "Mozart_MusikalischesWürfelspiel/"

use_random_seed 102 # which "random" variation

N = 16 # Total number of bars to generate
b = [] # new Array
# precompute dice rolls, enables repeated sections
N.times { b.push( rand_i(6) + rand_i(6) ) }

# play_bar_minuet (bar,roll) # play specified bar/roll of Mozart
#   bar [0-15], roll [0-10]
def play_bar_minuet (bar, roll)
  idx = bar * 11 + roll # bar * nstates + roll
  sample MozartDir, idx
  sleep sample_duration MozartDir, idx
end

# 24-bar minuet form, idx = |: 0..7 :| 8..15 |
24.times do |i|
  if i<16
    idx = i % 8
  else
    idx = i - 8
  end
  play_bar_roll idx, b[idx]
end

N = 16 # Total number of bars to generate
b = [] # new Array
# precompute dice rolls, enables repeated sections
N.times { b.push( rand_i(6) ) }

# play_bar_minuet (bar,roll) # play specified bar/roll of Mozart
#   bar [0-15], roll [0-10]
def play_bar_trio (bar, roll)
  idx = (16*11) + bar * 6 + roll # minuets + bar * nstates + roll
  sample MozartDir, idx
  sleep sample_duration MozartDir, idx
end

# 24-bar minuet form, idx = |: 0..7 :| 8..15 |
24.times do |i|
  if i<16
    idx = i % 8
  else
    idx = i - 8
  end
  play_bar_trio idx, b[idx]
end


