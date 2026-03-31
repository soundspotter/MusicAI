# =====================================================================
# Steve Reich's Phasing Technique in Sonic Pi
# =====================================================================
# Music and AI — Week 2
#
# Steve Reich's "Piano Phase" (1967): Two pianists play the same
# 12-note pattern. One gradually speeds up until they are one note
# ahead, then locks back in tempo. This process repeats, cycling
# through all 12 possible phase relationships.
#
# This is "process music" — Reich described it as
# "Music as a Gradual Process" (1968):
# "I want to be able to hear the process happening throughout
# the sounding music."

use_bpm 144

# The Piano Phase melody (12 notes) — scale degrees in E major
phrase = (ring 4, 6, 7, 4, 6, 7, 9, 7, 6, 4, 1, 2)

# Helper: convert scale degree to MIDI note (E major)
define :degree_to_note do |deg|
  (scale :e4, :major)[deg]
end


# --- Method 1: Gradual tempo offset ---
# Player 2 plays very slightly faster, causing gradual phase shift.
# sleep 0.5 vs sleep 0.493 means player 2 gains ~1.4% per note.
# After ~840 notes (~7 minutes), player 2 is a full cycle ahead.

live_loop :player1 do
  use_synth :sine
  n = degree_to_note(phrase.tick)
  play n, amp: 0.25, pan: -0.5, release: 0.3
  # Add subtle overtones (like the SC SynthDef's harmonics)
  play n + 12, amp: 0.08, pan: -0.5, release: 0.2
  sleep 0.5
end

live_loop :player2 do
  use_synth :sine
  n = degree_to_note(phrase.tick)
  play n, amp: 0.25, pan: 0.5, release: 0.3
  play n + 12, amp: 0.08, pan: 0.5, release: 0.2
  sleep 0.493  # Slightly faster — the phase gradually shifts
end


# --- Method 2: Discrete phase shifts ---
# Jump to specific phase offsets to hear each alignment.
# Uncomment this block (and comment out Method 1 above) to try.

comment do
  # Set the phase offset here (0-11)
  offset = 0  # Try 0, 1, 2, 3 ... 6 (max difference) ... 11
  puts "Phase offset: #{offset} notes"

  phrase_rotated = phrase.rotate(offset)

  live_loop :player1_discrete do
    use_synth :sine
    n = degree_to_note(phrase.tick)
    play n, amp: 0.25, pan: -0.5, release: 0.3
    play n + 12, amp: 0.08, pan: -0.5, release: 0.2
    sleep 0.5
  end

  live_loop :player2_discrete do
    use_synth :sine
    n = degree_to_note(phrase_rotated.tick)
    play n, amp: 0.25, pan: 0.5, release: 0.3
    play n + 12, amp: 0.08, pan: 0.5, release: 0.2
    sleep 0.5  # Same tempo — locked in phase
  end
end


# --- Method 3: Automatic phase walk ---
# Cycles through all 12 phase positions, staying at each for 8 reps.
# This lets you hear every possible alignment in sequence.

comment do
  live_loop :player1_walk do
    use_synth :sine
    n = degree_to_note(phrase.tick)
    play n, amp: 0.25, pan: -0.5, release: 0.3
    play n + 12, amp: 0.08, pan: -0.5, release: 0.2
    sleep 0.5
  end

  live_loop :player2_walk do
    use_synth :sine
    # Build the full sequence: 8 reps at each of the 12 phase offsets
    # Total = 12 offsets * 8 reps * 12 notes = 1152 notes
    # At 0.5 beats each at 144 BPM = ~4.8 minutes
    all_notes = (0..11).map { |offset|
      phrase.rotate(offset).to_a * 8
    }.flatten.ring

    n = degree_to_note(all_notes.tick)
    play n, amp: 0.25, pan: 0.5, release: 0.3
    play n + 12, amp: 0.08, pan: 0.5, release: 0.2
    sleep 0.5
  end
end


# --- Experiment ---
# 1. Try with different melodies (shorter or longer patterns)
# 2. What happens with a 7-note pattern? (prime number = no sub-patterns)
# 3. Add a third player with a different phase rate (e.g., sleep 0.487)
# 4. Use a richer synth: try :piano, :pluck, or :kalimba
# 5. Apply this to rhythm: two drum patterns with phasing
# 6. Try use_random_seed with .choose to hear deterministic but shifting textures
