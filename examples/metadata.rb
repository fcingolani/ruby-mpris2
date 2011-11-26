#!/usr/bin/env ruby

$:.unshift File.dirname(__FILE__)+'/../lib'

require 'mpris2'
require 'pp'

mpris2 = MPRIS2.new
mpris2.mediaplayers.each do | mediaplayer |
  puts mediaplayer.identity + ':'
  pp mediaplayer.player.metadata
end
