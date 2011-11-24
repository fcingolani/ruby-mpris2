class MPRIS2

  class MediaPlayer2
  
    class Player
    
      INTERFACE_NAME = 'org.mpris.MediaPlayer2.Player'
    
      def initialize( object )
        object.introspect unless object.introspected

        unless object.has_iface? INTERFACE_NAME
          raise(InterfaceNotImplementedException, 
            "#{object.destination} does not implement the #{INTERFACE_NAME} interface on #{object.path}." )
        end

        @interface = object[INTERFACE_NAME]
      end
    
   
      # MPRIS2 Methods
      
      def next
        @interface.Next
      end
      
      def previous
        @interface.Previous
      end
      
      def pause
        @interface.Pause
      end
      
      def play_pause
        @interface.PlayPause
      end
      
      def stop
        @interface.Stop
      end
      
      def play
        @interface.Play
      end
      
      def seek( x )
        @interface.Seek x
      end
      
      def set_position( track_id, position )
        @interface.SetPosition track_id, position
      end
      
      def open_uri( uri )
        @interface.OpenUri uri
      end
      
      # MPRIS2 Signals

      def on_seeked &block
        @interface.on_signal @interface.object.bus, 'Seeked', &block
      end
      
      # MPRIS2 Properties
      
      def playback_status
        @interface['PlaybackStatus']
      end
      
      def loop_status
        @interface['PlaybackStatus']
      end
      
      def loop_status=( status )
        @interface['PlaybackStatus'] = status
      end
      
      def rate
        @interface['Rate']
      end
      
      def rate=( playback_rate )
        @interface['Rate'] = playback_rate
      end
      
      def shuffle?
        @interface['Shuffle']
      end
      
      def shuffle=( shuffle )
        @interface['Shuffle'] = shuffle
      end
      
      def metadata
        @interface['Metadata'].first
      end
      
      def volume
        @interface['Volume'].first
      end
      
      def volume=( volume )
        @interface['Volume'] = Float(volume)
      end
      
      def position
        @interface['Position']
      end
      
      def minimum_rate
        @interface['MinimumRate']
      end
      
      def maximum_rate
        @interface['MaximumRate']
      end
      
      def can_go_next?
        @interface['CanGoNext']
      end
      
      def can_go_previous?
        @interface['CanGoPrevious']
      end
      
      def can_play?
        @interface['CanPlay']
      end
      
      def can_pause?
        @interface['CanPause']
      end
      
      def can_seek?
        @interface['CanSeek']
      end
      
      def can_control?
        @interface['CanControl']
      end
    
    end
    
  end
  
end
