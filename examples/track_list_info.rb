#!/usr/bin/env ruby

$:.unshift File.dirname(__FILE__)+'/../lib'

require 'mpris2'

mp = MPRIS2.media_player

if mp.has_track_list? then 
  puts MPRIS2.media_player.tracks
else
  puts "#{mp.identity} does not support the TrackList interface"
end
