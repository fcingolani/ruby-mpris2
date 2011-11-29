#!/usr/bin/env ruby

$:.unshift File.dirname(__FILE__)+'/../lib'

require 'mpris2'

MPRIS2.find_media_players.each do | media_player |
  if media_player.playback_status == 'Stopped' then
    puts "Closing #{media_player.identity}"
    media_player.quit
  end
end
