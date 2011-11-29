#!/usr/bin/env ruby

$:.unshift File.dirname(__FILE__)+'/../lib'

require 'mpris2'
require 'pp'

mp = MPRIS2.find_media_players.first

mp.on_volume_changed do | volume |
  puts "volume changed: #{volume}"
end

mp.on_metadata_changed do | metadata |
  puts "metadata changed:"
  pp metadata
end

mp.run_loop
