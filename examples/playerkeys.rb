#!/usr/bin/env ruby

$:.unshift File.dirname(__FILE__)+'/../lib'

require 'highline'
require 'mpris2'

mp = MPRIS2.find_media_players.first

puts "p:play space:pause s:stop [:prev ]:next q:quit"
puts "+:volume_up -:volume_down x:exit"

begin
  c = HighLine::SystemExtensions::get_character

  case c
    when 112 then
      puts "Play"
      mp.play
    when 113 then
      puts "Quit"
      mpris2.quit
    when 32 then
      puts "Pause"
      mp.pause
    when 115 then
      puts "Stop"
      mp.stop
    when 91 then
      puts "Previous"
      mp.previous
    when 93 then
      puts "Next"
      mp.next
    when 43 then
      vol = mp.volume + 0.05
      puts "Volume Up (#{vol})"
      mp.volume = vol
    when 45 then
      vol = mp.volume - 0.05
      puts "Volume Down (#{vol})"
      mp.volume = vol
    else
      puts "Unhandled key press: #{c}"
   end
    
end until (c == 120)
