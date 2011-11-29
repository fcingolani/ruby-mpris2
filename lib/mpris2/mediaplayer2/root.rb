class MPRIS2
  class MediaPlayer2
  
    # Provides basic control of the media player application.
    #
    # === Example: Close stopped media players
    # {include:file:examples/close_stopped_media_players.rb}
    #
    # @see http://www.mpris.org/2.1/spec/Root_Node.html
  
    module Root
    
      # D-Bus interface name for Root
    
      ROOT_IFACE_NAME = 'org.mpris.MediaPlayer2'
      
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
        root_iface.Raise
      end
      
      # Causes the media player to stop running.
      #
      # The media player may refuse to allow clients to shut it down. In this
      # case, the {#can_quit?} method returns false and this method does nothing.
      # @see #can_quit?
      # @raise [DBus::Error] If not supported.
      
      def quit
        root_iface.Quit
      end
      
      # If false, calling {#quit} will have no effect. If true, calling {#quit}
      # will cause the media application to attempt to quit (although it may still
      # be prevented from quitting by the user, for example).
      # @see #quit
      
      def can_quit?
        root_iface['CanQuit']
      end
      
      # If false, calling {#raise} will have no effect. If true, calling {#raise}
      # will cause the media application to attempt to bring its user interface
      # to the front, although it may be prevented from doing so (by the window
      # manager, for example).
      # @see #raise
      
      def can_raise?
        root_iface['CanRaise']
      end
      
      # Indicates whether the mediaplayer object supports a track list.
      # @see #track_list
      
      def has_track_list?
        root_iface['HasTrackList']
      end
      
      # A friendly name to identify the media player to users.
      # @return [String]
      
      def identity
        root_iface['Identity']
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
        root_iface['DesktopEntry']
      end
      
      # The URI schemes supported by the media player.
      #
      # This can be viewed as protocols supported by the player in almost all
      # cases. Almost every media player will include support for the "file" scheme. Other common schemes are "http" and "rtsp".
      #
      # Note that URI schemes should be lower-case.
      # @return [Array<String>] Supported URI Schemes
      
      def supported_uri_schemes
        root_iface['SupportedUriSchemes']
      end
      
      # The mime-types supported by the media player.
      #
      # Mime-types should be in the standard format (eg: audio/mpeg or
      # application/ogg).
      # @return [Array<String>] Supported MIME types.
      
      def supported_mime_types
        root_iface['SupportedMimeTypes']
      end
      
      def on_can_quit_changed( &block )
        on_property_changed 'CanQuit', &block
      end
      
      def on_can_raise_changed( &block )
        on_property_changed 'CanRaise', &block
      end
      
      def on_has_track_list_changed( &block )
        on_property_changed 'HasTrackList', &block
      end
      
      def on_identity_changed( &block )
        on_property_changed 'Identity', &block
      end
      
      def on_desktop_entry_changed( &block )
        on_property_changed 'DesktopEntry', &block
      end
      
      def on_supported_uri_schemes_changed( &block )
        on_property_changed 'SupportedUriSchemes', &block
      end
      
      def on_supported_mime_types_changed( &block )
        on_property_changed 'SupportedMimeTypes', &block
      end
    
      private
      
      def root_iface
        iface ROOT_IFACE_NAME
      end

    end
  end
end
