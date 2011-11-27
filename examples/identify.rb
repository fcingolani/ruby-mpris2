#!/usr/bin/env ruby

$:.unshift File.dirname(__FILE__)+'/../lib'

require 'mpris2'

mp = MPRIS2.find_media_players.first

puts "Identity: #{mp.identity}"
