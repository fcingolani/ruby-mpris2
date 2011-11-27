#!/usr/bin/env ruby

$:.unshift File.dirname(__FILE__)+'/../lib'

require 'mpris2'
require 'pp'

MPRIS2.find_media_players.each do | mp |
  puts mp.identity + ':'
  pp mp.metadata
end
