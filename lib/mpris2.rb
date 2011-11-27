# This Gem provides a way to control media players using the
# the D-Bus Media Player Remote Interfacing Specification (MPRIS) version 2.
# Author::    Federico Cingolani  (mailto:mail@fcingolani.com.ar)
# Copyright:: Copyright (c) 2011 Federico Cingolani
# License::   MIT License

require 'dbus'
require 'mpris2/mediaplayer2'

# Lists all the MPRISv2-capable services in a D-Bus connection.

class MPRIS2
  
  # Returns all the available media players in the D-Bus.
  # @param [DBus::Connection] dbus_connection DBus connection to scan. If not
  #   provided, the Session Bus will be used.
  # @return [Array<MediaPlayer2>]
  
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

end
