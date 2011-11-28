require 'mpris2/mediaplayer2/root'
require 'mpris2/mediaplayer2/player'
require 'mpris2/mediaplayer2/properties'

class MPRIS2

  # Allows you to interact with the MPRISv2 related interfaces of a given D-Bus
  # object.
  #
  # There are, at least, 3 interfaces to use:
  #
  # == org.mpris.MediaPlayer2 (a.k.a. Root)
  # Implemented by the {MediaPlayer2::Root} module
  # {include:MediaPlayer2::Root}
  # 
  # == org.mpris.MediaPlayer2.Player
  # Implemented by the {MediaPlayer2::Player} module
  # {include:MediaPlayer2::Player}

  class MediaPlayer2

    include Root
    include Player
    include Properties
    
    # The Object Path an MPRISv2 compliant player must expose
  
    OBJECT_PATH = "/org/mpris/MediaPlayer2"
    
    # @param [DBus::Connection] dbus_object The DBus object where the media
    #   player is being exposed
    def initialize( dbus_object )
      dbus_object.introspect unless dbus_object.introspected
      @object = dbus_object
    end
    
    # Create a new MediaPlayer2 from a DBus Service
    # @param [DBus::Service] dbus_service
    # @return [MediaPlayer2] A new MediaPlayer2 instance.
    def self.new_from_service( dbus_service )
      self.new dbus_service.object(OBJECT_PATH)
    end
  
    # Run a D-Bus loop to handle signals.
    
    def run_loop
      loop = DBus::Main.new
      loop << @object.bus
      loop.run
    end
  
    private
    
    # Return a D-Bus interface
    # @param [String] iface_name Interface name
    # @return [DBus::ProxyObjectInterface]
    # @raise [InterfaceNotImplementedException] if the media player does not
    #   implement the required interface name.
    
    def iface( iface_name )
      unless @object.has_iface? iface_name
        fail InterfaceNotImplementedException, "#{@object.path} does not implement the #{iface_name} interface."
      end
      @object[iface_name]
    end
    
    # Exception raised when an interface is not implemented
    
    class InterfaceNotImplementedException < Exception
    end
    
  end
end
