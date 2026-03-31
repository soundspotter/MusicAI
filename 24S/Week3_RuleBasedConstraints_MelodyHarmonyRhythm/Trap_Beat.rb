use_bpm 145

# Our chord sequence
p1 = [chord(:E3,"minor7"),
      chord(:G3,"major7"),
      chord(:A3,"minor7"),
      chord(:G3,"m9"),
      chord(:E3,"m9"),
      chord(:C3,"minor7"),
      chord(:Fs3,"major7"),
      chord(:D3,"m11")
      ]

# cc is Current chord, global variable
cc = chord(:E3,"minor")


# the main piano / chord loop
with_fx :level, amp: 0.5 do
  with_fx :reverb do
    with_synth :piano do
      live_loop :piano do
        p1.each {
          |c|
          cc = c
          play c, decay: 3.5
          play c+12, decay: 3.5, amp: 0.8
          sleep 1
          play c.choose+24, decay: 2, amp: 0.5
          sleep 1
          play c.choose+24, decay: 2, amp: 0.5
          sleep 2
        }
      end
    end
  end
end

# The bells ... extra melody
with_fx :reverb do
  with_fx :bitcrusher do
    with_fx :pitch_shift, pitch: 12, mix:  0.95 do
      with_synth :dull_bell do
        live_loop :bells do
          vs = [1,1,1,0, 1,0,1,0, 1,0,0,0, 0,0,1,0].ring
          play cc.choose+24, amp: 0.5*vs.tick(:vs)
          sleep 0.5
        end
      end
    end
  end
end

# Kicks
def kick(v)
  sample :bd_mehackit, amp: 2*v
end

# The regular kick
live_loop :kick1 do
  kick(1)
  sleep 5
  kick(1)
  sleep 3
end

# the irregular "bounce" kick
live_loop :kick2 do
  v=[0,0,0,0,0.7,0.9].choose
  kick(v)
  sleep 7
end

# The 808 / bass
def _808(p,v,d)
  play p-24, amp: v, attack: 0.3, decay: d, sustain: 0, release: 0.5
end

with_fx :slicer do |sl|
  live_loop :_808 do
    control sl, phase: [6,6,6,6,6,4,4,2,1,0.5].choose
    _808(cc[0],1,3.5)
    sleep 5
    _808(cc[0],1,1.6)
    sleep 3
  end
end

# snares ...
# why doesn't sonic pi come with better snare sounds?
def snare(v)
  sample :sn_generic, rate: 2, amp: 3*v, attack: 0, sustain: 0, release: 0, decay: 0.06
  sample :drum_snare_hard, rate: 2, amp: 1.5*v, attack: 0.01, sustain: 0, release: 0, decay: 0.03
end

with_fx :distortion do
  live_loop :snare do
    vs = [0,0,1,0, 0,0,1,0, 0,0,1,0, 0,0,1,1]
    vs.each {
      |v|
      snare(v)
      sleep 1
    }
  end
end

# Those all important hats
def hat(v)
  sample :drum_cymbal_closed, amp: 1.5*v, attack: 0, decay: 0.01, sustain: 0, release: 0
end

live_loop :hats do
  a = [0,0,0,1,1,2,2,2,2].choose
  case a
  when 0
    8.times do
      hat(1)
      sleep 0.5
    end
  when 1
    8.times do
      hat(1)
      sleep 0.25
    end
  when 2
    2.times do
      hat(1)
      sleep 0.3
      hat(1)
      sleep 0.3
      hat(1)
      sleep 0.4
    end
  end
end