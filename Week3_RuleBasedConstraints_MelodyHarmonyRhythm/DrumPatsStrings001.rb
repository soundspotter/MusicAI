
use_bpm 60

SC808_DIR = "~/SonicPI/TR808-SCSYNDEF"
load_synthdef "#{SC808_DIR}/bd.scsyndef"
load_synthdef "#{SC808_DIR}/sn.scsyndef"
load_synthdef "#{SC808_DIR}/hat.scsyndef"
load_synthdef "#{SC808_DIR}/openhihat.scsyndef"


live_loop :pats do
  set :bd_pat, "x..xx.x.x..xx.xx" #.shuffle
  set :sn_pat, "..x...x...x..x.x" #.shuffle
  set :hh_pat, "xxxxxxxxxxxxxxxx" #.shuffle
  sleep 1
end

use_synth :bd
live_loop :bd do
  if get[:bd_pat].tick == "x"
    play 1, amp: 0.5
  end
  sleep 0.25
end

live_loop :sn do
  if get[:sn_pat].tick == "x"
    sample :drum_snare_hard, amp: 0.5
  end
  sleep 0.25
end

live_loop :hh do
  if get[:hh_pat].tick == "x"
    sample :drum_cymbal_closed, amp: 0.5
  else
    if get[:hh_pat].look == "o"
      sample :drum_cymbal_open, amp: 0.75
    end
  end
  sleep 0.25
end

