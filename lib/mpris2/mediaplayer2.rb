require 'mpris2/mediaplayer2/player'

class MPRIS2

  # Implements methods to comunicate with the org.mpris.MediaPlayer2 interface
  # of a D-Bus object.
  #
  # @see http://www.mpris.org/2.1/spec/Root_Node.html

  class MediaPlayer2

    # D-Bus interface name for MediaPlayer2

    INTERFACE_NAME = 'org.mpris.MediaPlayer2';

    # Create a new MediaPlayer2 object.
    #
    # @param (DBus::ProxyObject) dbus_object
    # @raise [InterfaceNotImplementedException] If dbus_object does not
    #   implement the org.mpris.MediaPlayer2 interface.

    def initialize( dbus_object )
      dbus_object.introspect unless dbus_object.introspected

      unless dbus_object.has_iface? INTERFACE_NAME
        fail InterfaceNotImplementedException, "#{dbus_object.path} does not implement the #{INTERFACE_NAME} interface."
      end

      @interface = dbus_object[INTERFACE_NAME]
      
      @player = Player.new dbus_object
    end

    # Returns the Player instance associated with this MediaPlayer2
    # @return [Player]
    
    def player
      @player
    end
    
    # Returns the TrackList instance associated with this MediaPlayer2
    # @return [TrackList]
    # @see #has_track_list?
    # @todo IMPLEMENT
    
    def track_list
      @track_list
    end
        
    # Brings the media player's user interface to the front using any
    # appropriate mechanism available.
    #
    # The media player may be unable to control how its user interface is
    # displayed, or it may not have a graphical user interface at all.
    # In this case, the {#can_raise?} method returns false and this method does
    # nothing.
    # @see #can_raise?
    # @raise [DBus::Error] If not supported.
        
    def raise
      @interface.Raise
    end
    
    # Causes the media player to stop running.
    #
    # The media player may refuse to allow clients to shut it down. In this
    # case, the {#can_quit?} method returns false and this method does nothing.
    # @see #can_quit?
    # @raise [DBus::Error] If not supported.
    
    def quit
      @interface.Quit
    end
    
    # If false, calling {#quit} will have no effect. If true, calling {#quit}
    # will cause the media application to attempt to quit (although it may still
    # be prevented from quitting by the user, for example).
    # @see #quit
    
    def can_quit?
      @interface['CanQuit']
    end
    
    # If false, calling {#raise} will have no effect. If true, calling {#raise}
    # will cause the media application to attempt to bring its user interface
    # to the front, although it may be prevented from doing so (by the window
    # manager, for example).
    # @see #raise
    
    def can_raise?
      @interface['CanRaise']
    end
    
    # Indicates whether the mediaplayer object supports a track list.
    # @see #track_list
    
    def has_track_list?
      @interface['HasTrackList']
    end
    
    # A friendly name to identify the media player to users.
    # @return [String]
    
    def identity
      @interface['Identity']
    end
   
    # The basename of an installed .desktop file which complies with the Desktop
    # entry specification, with the ".desktop" extension stripped.
    #
    # Example: The desktop entry file is "/usr/share/applications/vlc.desktop",
    # and this property contains "vlc"
    #
    # This property is optional.
    # @return [String]
    
    def desktop_entry
      @interface['DesktopEntry']
    end
    
    # The URI schemes supported by the media player.
    #
    # This can be viewed as protocols supported by the player in almost all
    # cases. Almost every media player will include support for the "file" scheme. Other common schemes are "http" and "rtsp".
    #
    # Note that URI schemes should be lower-case.
    # @return [Array<String>] Supported URI Schemes
    
    def supported_uri_schemes
      @interface['SupportedUriSchemes']
    end
    
    # The mime-types supported by the media player.
    #
    # Mime-types should be in the standard format (eg: audio/mpeg or
    # application/ogg).
    # @return [Array<String>] Supported MIME types.
    
    def supported_mime_types
      @interface['SupportedMimeTypes']
    end

  end
  
end
