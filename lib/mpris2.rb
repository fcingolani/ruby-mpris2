# This Gem provides a way to control media players using the
# the D-Bus Media Player Remote Interfacing Specification (MPRIS) version 2.
# Author::    Federico Cingolani  (mailto:mail@fcingolani.com.ar)
# Copyright:: Copyright (c) 2011 Federico Cingolani
# License::   MIT License

require 'dbus'
require 'mpris2/mediaplayer2'

# Lists all the MPRISv2-capable services in a D-Bus connection.
#
# == Example: What type of files can i play?
# {include:file:examples/supported_mime_types.rb}
#
# == Example: Check playback status
# {include:file:examples/check_playback_status.rb}

class MPRIS2
  
  # Returns all the available media players in the D-Bus.
  # @param [DBus::Connection] dbus_connection DBus connection to scan. If not
  #   provided, the Session Bus will be used.
  # @return [Array<MediaPlayer2>] Found media players
  
  def self.find_media_players( dbus_connection=nil )
    if dbus_connection.nil?
      bus = DBus::SessionBus.instance
    else
      bus = dbus_connection
      bus.connect
    end
  
    bus.proxy.ListNames[0].select do |service_name|
      service_name =~ /^org.mpris.MediaPlayer2/
    end.collect do |service_name|
      MediaPlayer2.new_from_service(bus.service(service_name))
    end
  end
  
  # Returns the current media player, or the first one if there are many.
  # @param [DBus::Connection] dbus_connection DBus connection to scan. If not
  #   provided, the Session Bus will be used.
  # @return [MediaPlayer2] A media player
  # @raise [MediaPlayerNotFoundException] If there are no available media
  #   players
  
  def self.media_player( dbus_connection=nil )
    media_players = self.find_media_players( dbus_connection )
    
    if media_players.empty? then
      raise MediaPlayerNotFoundException, "There are no available media players"
    end
    
    media_players.first
  end

  private
  
  # Raised if there are no available media players
  
  class MediaPlayerNotFoundException < Exception
  end

end
