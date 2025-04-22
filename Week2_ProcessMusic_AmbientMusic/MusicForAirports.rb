# Prof. Michael A. Casey
# Dartmouth College, Department of Music, Department of Computer Science
# Course: Music and AI, 2023. Language: Sonic PI / Ruby
# Music for airports, cascading entries (aka a canon)

c1 = [:c5, :rest]
r1 = [1, 16.1]

c2 = [:af5, :f5, :f4, :rest]
r2 = [1,1,2,19.2]

c3 = [:af4, :c4, :ef4, :c3, :rest]
r3 = [2,2,2,2,25.5]

c4 = [:c2, :rest]
r4 = [4, 27.1]

c5 = [:f2, :f3, :eb3, :c3, :rest]
r5 = [0.5, 3.5, 2, 2, 12.8]

use_synth :piano
use_synth_defaults

# use_octave 3
# use_tuning :pythagorean

with_fx :reverb, mix: 0.5, room: 0.9, damp: 0 do
  live_loop :p1 do
    play_pattern_timed c1, r1
    cue :p2
  end
  
  live_loop :p2 do
    sync :p2
    play_pattern_timed c2, r2
    cue :p3
  end
  
  live_loop :p3 do
    sync :p3
    play_pattern_timed c3, r3
    cue :p4
  end
  
  live_loop :p4 do
    sync :p4
    play_pattern_timed c4, r4
    cue :p5
  end
  
  live_loop :p5 do
    sync :p5
    play_pattern_timed c5, r5
    cue :p6
  end
end
