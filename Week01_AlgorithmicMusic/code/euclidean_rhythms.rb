# =====================================================================
# Euclidean Rhythms -- The Bjorklund Algorithm
# =====================================================================
# Music and AI -- Week 1
#
# Euclidean rhythms distribute k onsets as evenly as possible across
# n steps. Remarkably, many traditional world music rhythms are
# Euclidean:
#
#   E(3,8)  = [x . . x . . x .] -- Cuban tresillo
#   E(5,8)  = [x . x x . x x .] -- Cuban cinquillo
#   E(5,12) = [x . . x . x . . x . x .] -- South African bell
#   E(7,12) = [x . x x . x . x x . x .] -- West African bell
#   E(4,12) = [x . . x . . x . . x . .] -- common 12/8 pulse
#   E(7,16) = [x . x x . x . x . x x . x . x .] -- Brazilian samba
#   E(2,5)  = [x . x . .] -- khafif-e-ramal (Persian)
#   E(3,4)  = [x . x x] -- cumbia (Colombia)
#
# The connection to Euclid: the algorithm for distributing onsets
# evenly is structurally identical to Euclid's algorithm for
# computing the greatest common divisor (GCD). Bjorklund (2003)
# discovered this while working on neutron accelerator timing at
# Los Alamos National Laboratory. Toussaint (2005) connected it
# to world music traditions.
#
# Sonic Pi has a built-in spread(k, n) function that generates
# Euclidean rhythms as boolean rings. We use it throughout.
#
# References:
#   Toussaint, "The Euclidean Algorithm Generates Traditional
#   Musical Rhythms" (2005)
#   Bjorklund, "The Theory of Rep-Rate Pattern Generation in the
#   SNS Timing System" (2003)
# =====================================================================


# --- Visualize a Euclidean rhythm ---
# Prints a grid: x = onset, . = rest
define :show_rhythm do |k, n, label=""|
  pat = spread(k, n)
  grid = pat.to_a.map { |b| b ? "x" : "." }.join(" ")
  name = label.length > 0 ? " -- #{label}" : ""
  puts "E(#{k},#{n}) = [#{grid}]#{name}"
end


# --- Display famous Euclidean rhythms ---
puts ""
puts "=== Famous Euclidean Rhythms ==="
show_rhythm 2, 5,  "khafif-e-ramal (Persian)"
show_rhythm 3, 4,  "cumbia (Colombia)"
show_rhythm 3, 8,  "tresillo (Cuba)"
show_rhythm 5, 8,  "cinquillo (Cuba)"
show_rhythm 4, 12, "12/8 pulse"
show_rhythm 5, 12, "South African bell"
show_rhythm 7, 12, "West African bell"
show_rhythm 7, 16, "Brazilian samba"
puts ""


# =============================================
# Example 1: Single Euclidean rhythm
# =============================================
# E(5,8) -- Cuban cinquillo
# spread(k,n) returns a boolean ring: (true, false, true, true, ...)
# We play on true, rest on false, each step = 1 subdivision

use_bpm 120

live_loop :euclidean do
  use_synth :beep
  pat = spread(5, 8)
  play :C5, amp: 0.5 if pat.tick
  sleep 0.5  # each step = an eighth note
end

# Uncomment to stop: stop


# =============================================
# Example 2: Layered Euclidean polyrhythm
# =============================================
# Different k values over the same n create interlocking patterns.
# This is how many West African drum ensembles work -- each
# instrument plays a different Euclidean pattern over a shared cycle.
#
# Comment out Example 1 before running this section.

=begin
use_bpm 110

# High: E(7,16) -- dense, samba-like pattern
live_loop :euc_high do
  use_synth :beep
  play :B6, amp: 0.2, sustain: 0.05, release: 0.05 if spread(7, 16).tick
  sleep 0.25  # sixteenth-note grid
end

# Mid: E(5,16) -- medium density
live_loop :euc_mid do
  use_synth :beep
  play :C5, amp: 0.4, sustain: 0.1, release: 0.05 if spread(5, 16).tick
  sleep 0.25
end

# Low: E(3,16) -- sparse bass pulse
live_loop :euc_low do
  use_synth :beep
  play :C3, amp: 0.6, sustain: 0.15, release: 0.1 if spread(3, 16).tick
  sleep 0.25
end
=end


# =============================================
# Example 3: Polymetric Euclidean
# =============================================
# Different step counts (n) create polymetric feel.
# E(3,8) against E(4,12) = 3-against-4 polyrhythm.
#
# Comment out previous examples before running this section.

=begin
use_bpm 100

live_loop :poly_a do
  use_synth :beep
  pat = spread(3, 8)
  play :C4, amp: 0.5, sustain: 0.15, release: 0.05 if pat.tick
  sleep 0.5  # 8 steps per 4 beats
end

live_loop :poly_b do
  use_synth :beep
  pat = spread(4, 12)
  play :E5, amp: 0.3, sustain: 0.08, release: 0.05 if pat.tick
  sleep 1.0/3  # 12 steps per 4 beats (triplet grid)
end
=end


# =============================================
# Example 4: Rotation changes the groove
# =============================================
# The same E(3,8) pattern sounds very different depending on
# which beat is treated as the downbeat.
# spread(k, n, rotate: r) shifts the pattern start.
#
# Comment out previous examples before running this section.

=begin
use_bpm 120

puts "E(3,8) with different rotations:"
show_rhythm 3, 8, "rotation 0 (standard tresillo)"

# Try changing the rotation value: 0, 1, 2, etc.
rotation = 0

live_loop :rotated do
  use_synth :beep
  pat = spread(3, 8, rotate: rotation)
  play :C5, amp: 0.4 if pat.tick
  sleep 0.5
end
=end


# =============================================
# Example 5: Melodic Euclidean
# =============================================
# Euclidean rhythms are not just for percussion --
# they can drive melodic patterns too.
#
# Comment out previous examples before running this section.

=begin
use_bpm 108

# Dorian scale degrees as MIDI notes
dorian_melody = (ring :D5, :F5, :A5, :B5, :D6, :B5, :A5, :F5)
dorian_bass   = (ring :D3, :D3, :G3, :G3, :A3, :A3, :D3, :D3)

# Melody on cinquillo rhythm E(5,8)
live_loop :euc_melody do
  use_synth :beep
  pat = spread(5, 8)
  if pat.tick
    play dorian_melody.look, amp: 0.35, sustain: 0.25, release: 0.05
  end
  sleep 0.5
end

# Bass on tresillo rhythm E(3,8)
live_loop :euc_bass do
  use_synth :beep
  pat = spread(3, 8)
  if pat.tick
    play dorian_bass.look, amp: 0.45, sustain: 0.4, release: 0.1
  end
  sleep 0.5
end
=end


# --- Experiments ---
#
# 1. Rotation: spread(k, n, rotate: r)
#    The rotate parameter shifts which step is the "downbeat."
#    Same pattern, completely different groove feel.
#
# 2. Coprime numbers: When GCD(k,n) = 1, the pattern has maximum
#    complexity. Compare spread(3,8) vs spread(4,8) vs spread(3,9).
#
# 3. Layer 4+ Euclidean patterns with different synths.
#    Try :pluck, :tb303, :prophet for timbral variety.
#
# 4. Dynamic density: randomly switch between k values
#    k = [3, 5, 7].choose
#    pat = spread(k, 16)
#
# 5. Sonic Pi's spread() is the built-in Bjorklund algorithm.
#    Compare: puts spread(3,8) to see the boolean ring directly.
#    Try: puts spread(3,8).to_a.map{|b| b ? "x" : "."}.join(" ")
