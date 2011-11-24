#!/usr/bin/env ruby

$:.unshift File.dirname(__FILE__)+'/../lib'

require 'mpris2'

mpris2 = MPRIS2.new

# Test to set and get the playback volume of the media player
for vol_in in 0..150
  mpris2.mediaplayer.player.volume = vol_in
  vol_out = mpris2.mediaplayer.player.volume
  puts "Setting volume to: #{vol_in}, got back: #{vol_out}."
end
