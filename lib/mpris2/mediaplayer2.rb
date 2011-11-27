require 'mpris2/mediaplayer2/root'
require 'mpris2/mediaplayer2/player'
require 'mpris2/mediaplayer2/properties'

class MPRIS2
  class MediaPlayer2

    include Root
    include Player
    include Properties
    
    # The Object Path an MPRISv2 compliant player must expose
  
    OBJECT_PATH = "/org/mpris/MediaPlayer2"
    
    def initialize( dbus_object )
      dbus_object.introspect unless dbus_object.introspected
      @object = dbus_object
    end
    
    def self.new_from_service( service )
      self.new service.object(OBJECT_PATH)
    end
  
    # Run a D-Bus loop to handle signals.
    
    def run_loop
      loop = DBus::Main.new
      loop << @object.bus
      loop.run
    end
  
    private
    
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
