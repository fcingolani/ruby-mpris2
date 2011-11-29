#!/usr/bin/env ruby

$:.unshift File.dirname(__FILE__)+'/../lib'

require 'mpris2'

MPRIS2.media_player.next
