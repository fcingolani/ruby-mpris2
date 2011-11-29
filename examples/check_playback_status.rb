#!/usr/bin/env ruby

$:.unshift File.dirname(__FILE__)+'/../lib'

require 'mpris2'

MPRIS2.find_media_players.each do | media_player |
  puts "#{media_player.identity} is #{media_player.playback_status}"
end
