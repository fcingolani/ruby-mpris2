#!/usr/bin/env ruby

$:.unshift File.dirname(__FILE__)+'/../lib'

require 'mpris2'

mpris = MPRIS2.new
puts "Identity: #{mpris.mediaplayer.identity}"
