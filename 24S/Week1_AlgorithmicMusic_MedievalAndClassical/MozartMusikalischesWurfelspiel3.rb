# W. A. Mozart Musikalisches Würfelspiel (K. 294dK3 or K. 516fK6)
# published in 1792, by Mozart's publisher Nikolaus Simrock in Berlin
#
# Michael Casey
# Music and AI
# Dartmouth College, CS Dept., 24S

MozartDir = "Mozart_MusikalischesWürfelspiel/"
use_random_seed 99 # which "random" variation

# Play 24-bar minuet form, idx = |: 0..7 :| 8..15 |
def play_minuet (nstates: 11, offset: 0, num_bars: 16) # offset=0 (minuet) =16*11 (trio)
  d = [] # precompute dice rolls, enables repeated sections
  if nstates>6   # 2 dice
    num_bars.times { d.push( rand_i (6) + rand_i(6) ) }
  else   # 1 die
    num_bars.times { d.push( rand_i 6 ) }
  end
  (24).times do |i|
    bar = i % ( num_bars / 2 )
    if i >= num_bars
      bar = i - ( num_bars / 2 )
    end
    idx = offset + bar * nstates + d[bar]
    sample MozartDir, idx
    sleep sample_duration MozartDir, idx
  end
end

play_minuet nstates: 11, offset: 0 # Minuet Section
play_minuet nstates: 6 , offset: 16 * 11 # Trio Section



