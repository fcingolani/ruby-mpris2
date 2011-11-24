#!/usr/bin/env ruby

$:.unshift File.dirname(__FILE__)+'/../lib'

require 'rubygems'
require 'highline'
require 'mpris2'


mpris2 = MPRIS2.new

puts "p:play space:pause s:stop [:prev ]:next q:quit"
puts "+:volume_up -:volume_down x:exit"

begin
  c = HighLine::SystemExtensions::get_character

  case c
    when 112 then
      puts "Play"
      mpris2.mediaplayer.player.play
    when 113 then
      puts "Quit"
      mpris2.quit
    when 32 then
      puts "Pause"
      mpris2.mediaplayer.player.pause
    when 115 then
      puts "Stop"
      mpris2.mediaplayer.player.stop
    when 91 then
      puts "Previous"
      mpris2.mediaplayer.player.previous
    when 93 then
      puts "Next"
      mpris2.mediaplayer.player.next
    when 43 then
      vol = mpris2.mediaplayer.player.volume + 5
      puts "Volume Up (#{vol})"
      mpris2.mediaplayer.player.volume = vol
    when 45 then
      vol = mpris2.mediaplayer.player.volume - 5
      puts "Volume Down (#{vol})"
      mpris2.mediaplayer.player.volume = vol
    else
      puts "Unhandled key press: #{c}"
   end
    
end until (c == 120)
