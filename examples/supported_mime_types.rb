#!/usr/bin/env ruby

$:.unshift File.dirname(__FILE__)+'/../lib'

require 'mpris2'

puts MPRIS2.media_player.supported_mime_types
