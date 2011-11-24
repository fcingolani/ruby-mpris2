require 'dbus'

require 'mpris2/mediaplayer2'

class MPRIS2

  OBJECT_PATH = "/org/mpris/MediaPlayer2"

  def initialize( dbus_address=nil )

    if dbus_address.nil?
      @bus = DBus::SessionBus.instance
    else
      @bus = DBus::Connection.new(dbus_address)
      @bus.connect
    end
    
    scan_mediaplayers

  end
  
  def create_mediaplayer_from_service_name( service_name )
    @service = @bus.service(service_name)
    object = @service.object(OBJECT_PATH)
    return MediaPlayer2.new object
  end
  
  def scan_mediaplayers
    @mediaplayers = []
    @bus.proxy.ListNames[0].each do |service_name|
      if service_name =~ /^org.mpris.MediaPlayer2/ then
        @mediaplayers.push( create_mediaplayer_from_service_name(service_name) )
      end
    end
  end
  
  def mediaplayer
    raise( ServiceNotFoundException, "No MPRIS2 service found on '#{@bus.unique_name}' bus." ) if @mediaplayers.empty?
    
    @mediaplayers.first
  end

  def mediaplayers
    @mediaplayers
  end
  
  def run
    loop = DBus::Main.new
    loop << @bus
    loop.run
  end
  
  class InterfaceNotImplementedException < Exception
  end
  
  class ServiceNotFoundException < Exception
  end

end
