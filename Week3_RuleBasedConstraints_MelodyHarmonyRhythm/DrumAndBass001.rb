# Prof. Michael A. Casey
# Dartmouth College, Department of Music, Department of Computer Science
# Course: Music and AI, 2023. Language: Sonic PI / Ruby
#
# Week 1: Algorithmic Roland TR-808 Trap patterns
#
# Michael A. Casey
# Dartmouth College, Department of Music,
# Department of Computer Science
# Language: Sonic PI / Ruby

# Excercise: ClapTrap
#
# * define 3 incommensurate loops
# * beatbox or clap or them together

use_bpm 60
use_random_seed 101

SC808_DIR = "~/SonicPI/TR808-SCSYNDEF"
load_synthdef "#{SC808_DIR}/bd.scsyndef"
load_synthdef "#{SC808_DIR}/sn.scsyndef"
load_synthdef "#{SC808_DIR}/hat.scsyndef"
load_synthdef "#{SC808_DIR}/openhihat.scsyndef"

use_synth :bd
live_loop :bd do
  sync :timesync
  play 60, amp: 0.5
  sleep 0.25
  play 60, amp: 0.5
  sleep 0.25
  2.times do
    play 60, amp: 0.5
    sleep 1
  end
end

use_synth :sn
live_loop :sn do
  sync :timesync
  7.times do
    sleep 0.5
    play 60, amp: 0.5
    sleep 0.5
  end
  sleep 0.75
  play 60, amp: 0.5
  sleep 0.25
end

use_synth :hat
live_loop :hat do
  sync :timesync
  7.times do
    play 60, on: true, amp: 0.5
    sleep 0.25
  end
  n = [2,3,2,2,3,3,3,5,2,5,3,5,3,5,2,3].tick
  n.times do
    play 60, on: true, amp: 0.5
    sleep 0.25/n
  end
end

use_synth :openhihat
live_loop :openhihat do
  sync :timesync
  31.times do
    sleep 0.25
  end
  play 60
  sleep 0.25
end

bass_idx = [0, 0, 3, 0, 4, 4, 3, 3, 2, 2, 4, 2, 3, 3, 4, 4].shuffle
live_loop :bass do
  sync :timesync
  with_fx :echo, phase: 0.125, decay: 2, mix: 0.7 do
    use_synth :bass_foundation
    bass_gate =[1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0].shuffle
    bass_scl = scale :c2, scale_names.choose , num_octaves: 3
    64.times do
      play bass_scl[bass_idx.tick], release: 0.55 - bass_idx.look / 8.0, cutoff: 50+(bass_idx.look*5), amp: bass_gate.look
      sleep 0.25
    end
  end
end


live_loop :timesync do
  cue :timesync
  sleep 0.25
end



