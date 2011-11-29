#!/usr/bin/env ruby

$:.unshift File.dirname(__FILE__)+'/../lib'

require 'mpris2'

track_md = MPRIS2.media_player.metadata
puts "You are listening \"#{track_md['xesam:title']}\" by #{track_md['xesam:artist']}"
