# W. A. Mozart Musikalisches Würfelspiel (K. 294dK3 or K. 516fK6)
# published in 1792, by Mozart's publisher Nikolaus Simrock in Berlin
#
# Michael Casey
# Music and AI
# Dartmouth College, CS Dept., 24S

MozartDir = "Mozart_MusikalischesWürfelspiel/"

use_random_seed 1050

b = Array(0..16)

b.length.times do |i| # precompute dice rolls
  b[i] = rrand_i(1,6) + rrand_i(1,6) - 2
end

puts b

def foo(i,r) # play sample segment (i) with dice roll (r)
  idx = i*11 + r
  dur =  sample_duration MozartDir, idx
  sample MozartDir, idx
  sleep dur
end

(7).times do |i|
  foo i, b[i]
end

foo 7, b[7]

7.times do |i|
  foo i, b[i]
end

foo 8, b[8]

7.times do |i|
  foo i+9, b[i+9]
end







