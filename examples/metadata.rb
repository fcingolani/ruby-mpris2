#!/usr/bin/env ruby

$:.unshift File.dirname(__FILE__)+'/../lib'

require 'mpris2'
require 'pp'

mpris2 = MPRIS2.new
pp mpris2.mediaplayer.player.metadata

