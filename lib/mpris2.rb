# This Gem provides a way to control media players using the
# the D-Bus Media Player Remote Interfacing Specification (MPRIS) version 2.
# Author::    Federico Cingolani  (mailto:mail@fcingolani.com.ar)
# Copyright:: Copyright (c) 2011 Federico Cingolani
# License::   MIT License

require 'dbus'
require 'mpris2/mediaplayer2'

# MPRIS2 objects hook to a D-Bus connection and lists all the MPRIS-capable
# services in it trough mediaplayers (and mediaplayer).

class MPRIS2

  # The Object Path an MPRISv2 compliant player must expose
  
  OBJECT_PATH = "/org/mpris/MediaPlayer2"

  # Create a new MPRIS2 object.
  #
  # @param [DBus::Connection] dbus_connection If not provided, the Session Bus
  #   will be used.

  def initialize( dbus_connection=nil )
    if dbus_connection.nil?
      @bus = DBus::SessionBus.instance
    else
      @bus = dbus_connection
      @bus.connect
    end
  end
  
  # Returns all the available mediaplayers in the D-Bus.
  # @return [Array<MediaPlayer2>]

  def mediaplayers
    scan_mediaplayers
    @mediaplayers
  end
  
  # Returns the first mediaplayer found in the D-Bus.
  # 
  # @return [MediaPlayer2]
  # @raise [MediaplayerNotFoundException] If there are no available mediaplayers.
  
  def mediaplayer
    scan_mediaplayers
    
    if @mediaplayers.empty? then
      raise( MediaplayerNotFoundException, "No MPRIS2 mediaplayer found on '#{@bus.unique_name}' bus." )
    end
    
    @mediaplayers.first
  end
  
  # Run a D-Bus loop to handle signals.
  
  def run_loop
    loop = DBus::Main.new
    loop << @bus
    loop.run
  end
  
  private
  
  # Create a MediaPlayer2 object from a D-Bus Service name
  # @param [String] service_name
  # @return [MediaPlayer2]
  def create_mediaplayer_from_service_name( service_name )
    service = @bus.service(service_name)
    object = service.object(OBJECT_PATH)
    return MediaPlayer2.new object
  end
  
  # Scan the D-Bus for mediaplayers
  
  def scan_mediaplayers
    @mediaplayers = []
    @bus.proxy.ListNames[0].each do |service_name|
      if service_name =~ /^org.mpris.MediaPlayer2/ then
        @mediaplayers.push( create_mediaplayer_from_service_name(service_name) )
      end
    end
  end
  
  # Exception raised when an interface is not implemented
  
  class InterfaceNotImplementedException < Exception
  end
  
  # Exception raised when cannot find an MPRISv2 mediaplayer
  
  class MediaplayerNotFoundException < Exception
  end

end
