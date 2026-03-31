# Generate Melody and Accompaniment from Harmony (chords)

roots = [:c5, :f5, :b4, :e5, :a4, :d5, :g4, :c5]
chords = [:M7, :M7, :dim7, :m7, :m7, :m7, '7', :M7]
rhythm = [1,2,2,2,2,2,2,1]

(4*chords.length).times do
  
  c = chord(roots.tick, chords.look, num_octaves: 2)
  
  use_synth :bass_foundation
  play roots.look-24
  
  use_synth :piano
  8.times do |i|
    if i<7
      play c[i*3%5], amp: 0.25, release: 0.5
    end
    sleep rhythm.look / 8.0
  end
  
  n = rrand_i(1,4)*2
  puts n
  use_synth :pluck
  n.times do
    play chord(roots.look, chords.look).choose, amp: 0.5, release: 2.5
    play chord(roots.look, chords.look).choose+12, amp: 0.5, release: 2.5
    sleep rhythm.look / (1.0*n)
  end
end

