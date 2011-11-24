require 'mpris2/mediaplayer2/player'

class MPRIS2

  class MediaPlayer2

    INTERFACE_NAME = 'org.mpris.MediaPlayer2';

    def initialize( object )
      object.introspect unless object.introspected

      #@todo mejorar
      unless object.has_iface? INTERFACE_NAME
        raise(InterfaceNotImplementedException, 
          "#{object.service.name} does not implement the MediaPlayer2 interface on /org/mpris/MediaPlayer2." )
      end

      @interface = object[INTERFACE_NAME]
      
      @player = Player.new object      
    end
    
    #
    
    def player
      @player
    end
    
    # MPRIS2 Methods
    
    def raise
      @interface.Raise
    end
    
    def quit
      @interface.Quit
    end
    
    # MPRIS2 Properties
    
    def can_quit?
      @interface['CanQuit']
    end
    
    def can_raise?
      @interface['CanRaise']
    end
    
    def has_tracklist?
      @interface['HasTrackList']
    end
    
    def identity
      @interface['Identity']
    end
    
    def desktop_entry
      @interface['DesktopEntry']
    end
    
    def suppored_uri_schemes
      @interface['SupportedUriSchemes']
    end
    
    def supported_mime_types
      @interface['SupportedMimeTypes']
    end

  end
  
end
