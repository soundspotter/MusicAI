# Prof. Michael A. Casey
# Dartmouth College, Department of Music, Department of Computer Science
# Course: Music and AI, 2023. Language: Sonic PI / Ruby
h = {
  0=>[0,1,2,3,1],
  1=>[2,3,4,5,3,2],
  2=>[2,0,1,5],
  3=>[1,3,4,6],
  4=>[2,0,2],
  5=>[3,2,5],
  6=>[2,3,1]
}

puts h[1]

degree = 0

live_loop :markov do
  play scale(:E, :major)[degree]
  degree = h[degree].choose
  sleep 0.25
end
