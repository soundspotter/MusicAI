# Prof. Michael A. Casey
# Dartmouth College, Department of Music, Department of Computer Science
# Course: Music and AI, 2023. Language: Sonic PI / Ruby
# Music for airports, cascading entries (aka a canon)

p1 = [:c5, :rest]
r1 = [1, 16.1]

p2 = [:af5, :f5, :f4, :rest]
r2 = [1,1,2,19.2]

p3 = [:af4, :c4, :ef4, :c3, :rest]
r3 = [2,2,2,2,25.5]

p4 = [:c2, :rest]
r4 = [4, 27.1]

p5 = [:f2, :f3, :eb3, :c3, :rest]
r5 = [0.5, 3.5, 2, 2, 12.8]

p6 = [[:f4,:c5,:f5,:g5],:rest]
r6 = [4,12]

p7 = [:c3,:rest]
r7 = [4,26]

p8 = [:eb3,:ab2]
r8 = [4,4]


use_synth :piano
use_synth_defaults sustain: 8, attack: 0.02, release: 10
max_delay = 30

with_fx :reverb, mix: 0.9, room: 0.95, damp: 0.4 do
  
  at rand(max_delay) do
    live_loop :p1 do
      play_pattern_timed p1, r1
    end
  end
  
  at rand(max_delay) do
    live_loop :p2 do
      play_pattern_timed p2, r2
    end
  end
  
  at rand(max_delay) do
    live_loop :p3 do
      play_pattern_timed p3, r3
    end
  end
  
  at rand(max_delay) do
    live_loop :p4 do
      play_pattern_timed p4, r4
    end
  end
  
  at rand(max_delay) do
    live_loop :p5 do
      play_pattern_timed p5, r5
    end
  end
  
  at rand(max_delay) do
    live_loop :p6 do
      play_pattern_timed p6, r6
    end
  end
  
  at rand(max_delay) do
    live_loop :p7 do
      play_pattern_timed p7, r7
    end
  end
  
  at rand(max_delay) do
    live_loop :p8 do
      play_pattern_timed p8, r8
    end
  end
end
