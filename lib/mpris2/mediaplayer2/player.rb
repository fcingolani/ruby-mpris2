class MPRIS2
  class MediaPlayer2
  
    # Implements methods to comunicate with the org.mpris.MediaPlayer2.Player
    # interface of a D-Bus object.
    #
    # For more information check http://www.mpris.org/2.1/spec/Player_Node.html
  
    module Player
      
      # D-Bus interface name for Player
    
      PLAYER_IFACE_NAME = 'org.mpris.MediaPlayer2.Player'
      
      # Skips to the next track in the track list.
      #
      # If there is no next track (and endless playback and track repeat are 
      # both off), stop playback. If playback is paused or stopped, it remains
      # that way. If {#can_go_next?} returns false, attempting to call this
      # method should have no effect.
      # @raise [DBus::Error] If not supported.
      # @see #can_go_next?
      # @see #can_control?
      
      def next
        player_iface.Next
      end
      
      # Skips to the previous track in the tracklist.
      #
      # If there is no previous track (and endless playback and track repeat are
      # both off), stop playback. If playback is paused or stopped, it remains
      # that way. If {#can_go_previous?} returns false, attempting to call this
      # method should have no effect.
      # @raise [DBus::Error] If not supported.
      # @see #can_go_previous?
      # @see #can_control?
      
      def previous
        player_iface.Previous
      end
      
      # Pauses playback.
      #
      # If playback is already paused, this has no effect. Calling {#play} after
      # this should cause playback to start again from the same position. If
      # {#can_pause?} returns false, attempting to call this method should have
      # no effect.
      # @raise [DBus::Error] If not supported.
      # @see #can_pause?
      # @see #can_control?
      
      def pause
        player_iface.Pause
      end
      
      # Pauses or resumes playback.
      #
      # If playback is already paused, resumes playback.If playback is stopped,
      # starts playback. If {#can_pause?} returns false, attempting to call this
      # method should have no effect and raise an error.
      # @raise [DBus::Error] If not supported.
      # @see #can_pause?
      # @see #can_control?
      
      def play_pause
        player_iface.PlayPause
      end
      
      # Stops playback.
      #
      # If playback is already stopped, this has no effect. Calling {#play}
      # after this should cause playback to start again from the beginning of
      # the track. If {#can_control?} is false, attempting to call this method
      # should have no effect and raise an error.
      # @raise [DBus::Error] If not supported.
      # @see #can_control?
      
      def stop
        player_iface.Stop
      end
      
      # Starts or resumes playback.
      #
      # If already playing, this has no effect. If there is no track to play,
      # this has no effect. If {#can_play?} is false, attempting to call this
      # method should have no effect.
      # @raise [DBus::Error] If not supported.
      # @see #can_play?
      # @see #can_control?
      
      def play
        player_iface.Play
      end
      
      # Seeks forward in the current track by the specified number of
      # microseconds.
      #
      # A negative value seeks back. If this would mean seeking back further
      # than the start of the track, the position is set to 0. If the value
      # passed in would mean seeking beyond the end of the track, acts like a
      # call to {#next}. If the {#can_seek?} property is false, this has no
      # effect.
      # @param [Number] microseconds The number of microseconds to seek forward.
      # @raise [DBus::Error] If not supported.
      # @see #can_seek?
      # @see #can_control?

      def seek( microseconds )
        player_iface.Seek microseconds
      end

      # Sets the current track position in microseconds.
      #
      # If the position argument is less than 0, do nothing. If the position
      # argument is greater than the track length, do nothing. If the
      # {#can_seek?}  property is false, this has no effect.
      #
      # @param [String] track_id The currently playing track's identifier.
      #   If this does not match the id of the currently-playing track, the call
      #   is ignored as "stale".
      # @param [Number] position Track position in microseconds. This must be
      #   between 0 and <track_length>.
      # @raise [DBus::Error] If not supported.
      # @see #can_seek?
      # @see #can_control?
      # @note The reason for having this method, rather than making
      #   {#position} writable, is to include the track_id argument to avoid race
      #   conditions where a client tries to seek to a position when the track has
      #   already changed.
      
      def set_position( track_id, position )
        player_iface.SetPosition track_id, position
      end

      # Opens the URI given as an argument
      #
      # If the playback is stopped, starts playing. If the uri scheme or the
      # mime-type of the uri to open is not supported, this method does nothing
      # and may raise an error. In particular, if the list of available uri
      # schemes is empty, this method may not be implemented. Clients should not
      # assume that the URI has been opened as soon as this method returns. They
      # should wait until the mpris:trackid field in the {#metadata} property
      # changes.
      # @param [String] uri Uri of the track to load. Its uri scheme should be
      #   an element of {#supported_uri_schemes} and the mime-type should match
      #   one of the elements of the {#supported_mime_types}.
      # @raise [DBus::Error] If the uri scheme or the mime-type of the uri to
      #   open is not supported.
      # @see #supported_uri_schemes
      # @see #supported_mime_types
      
      def open_uri( uri )
        player_iface.OpenUri uri
      end
      
      # Indicates that the track position has changed in a way that is
      # inconsistent with the current playing state.
      #
      # When this signal is not received, clients should assume that:
      # * When playing, the position progresses according to {#rate}.
      # * When paused, it remains constant.
      #
      # This signal does not need to be emitted when playback starts or when the
      # track changes, unless the track is starting at an unexpected position.
      # An expected position would be the last known one when going from Pause
      # to Playing, and 0 when going from Stopped to Playing
      # @yieldparam [Number] position The new position, in microseconds.

      def on_seeked( &block )
        player_iface.on_signal @object.bus, 'Seeked', &block
      end
      
      # The current playback status.
      # @return [String] May be "Playing", "Paused" or "Stopped".
      
      def playback_status
        player_iface['PlaybackStatus']
      end
      
      # Returns the current loop / repeat status
      #
      # May be:
      # * "None" if the playback will stop when there are no more tracks to play
      # * "Track" if the current track will start again from the begining once it has finished playing
      # * "Playlist" if the playback loops through a list of tracks
      # @return [String] May be "None", "Track" or "Playlist".
      
      def loop_status
        player_iface['LoopStatus']
      end
      
      # Sets the current loop / repeat status
      #
      # If {#can_control?} is false, attempting to set this property should
      # have no effect and raise an error.
      # @param [String] status "None", "Track" or "Playlist".
      # @raise [DBus::Error] If not supported.
      # @see #can_control?
      
      def loop_status=( status )
        player_iface['LoopStatus'] = status
      end

      # Returns the current playback rate.
      #
      # If the media player has no ability to play at speeds other than the
      # normal playback rate, this must still be implemented, and must return
      # 1.0. The {#minimum_rate} and {#maximum_rate} properties will also be set
      # to 1.0.
      # @return [Number]
      # @see #minimum_rate
      # @see #maximum_rate
      
      def rate
        player_iface['Rate']
      end
      
      # Sets the playback rate.
      #
      # The value must fall in the range described by {#minimum_rate} and
      # {#maximum_rate}, and must not be 0.0. If playback is paused, the
      # {#playback_status} will indicate this.
      # A value of 0.0 should not be set by the client. If it is, the media
      # player should act as though {#pause} was called.
      # @param [Number] playback_rate The new playback rate. Not all values may
      #   be accepted by the media player. It is left to media player
      #   implementations to decide how to deal with values they cannot use;
      #   they may either ignore them or pick a "best fit" value. Clients are
      #   recommended to only use sensible fractions or multiples of 1 (eg: 0.5,
      #   0.25, 1.5, 2.0, etc).
      # @raise [DBus::Error] If not supported.
      # @see #minimum_rate
      # @see #maximum_rate
      # @see #playback_status
      # @see #pause
      
      def rate=( playback_rate )
        player_iface['Rate'] = playback_rate
      end
      
      # Returns the Shuffle status
      #
      # A value of false indicates that playback is progressing linearly through
      # a playlist, while true means playback is progressing through a playlist
      # in some other order.
      # @return [Boolean] Shuffle status.
      
      def shuffle?
        player_iface['Shuffle']
      end
      
      # Sets the Shuffle status
      #
      # If {#can_control?} is false, attempting to set this property should have
      # no effect and raise an error.
      # @param [Boolean] shuffle The new Shuffle status.
      # @raise [DBus::Error] If not supported.
      
      def shuffle=( shuffle )
        player_iface['Shuffle'] = shuffle
      end
      
      # The metadata of the current element.
      #
      # If there is a current track, this must have a "mpris:trackid" entry
      # at the very least, which contains a D-Bus path that uniquely identifies
      # this track.
      # @return [Hash{String => Object}] The track metadata.

      def metadata
        player_iface['Metadata']
      end
      
      # Returns the volume level.
      # @return [Number]
      
      def volume
        player_iface['Volume']
      end
      
      # Sets the volume level
      # 
      # If a negative value is passed, the volume will be set to 0.0.
      # If {#can_control?} is false, attempting to set this property should have
      # no effect and raise an error.
      # @param [Boolean] shuffle The new Volume Level.
      # @raise [DBus::Error] If not supported.
      # @see #can_control?
      
      def volume=( volume )
        player_iface['Volume'] = Float(volume)
      end
      
      # Returns the current track position in microseconds, between 0 and the
      # 'mpris:length' {#metadata} entry.
      # @return [Number] The current track position.
      # @see #metadata
      # @see #seek
      # @see #set_position
      
      def position
        player_iface['Position']
      end
      
      # The minimum value which the {#rate} method can take. Clients should not
      # attempt to set the {#rate} value below this value.
      #
      # Note that even if this value is 0.0 or negative, clients should
      # not attempt to set the {#rate} value to 0.0.
      # This value should always be 1.0 or less.
      # @return [Number] The minimum rate
      # @see #rate
      
      def minimum_rate
        player_iface['MinimumRate']
      end
      
      # The maximum value which the {#rate} method can take. Clients should not
      # attempt to set the {#rate} value above this value.
      # This value should always be 1.0 or greater.
      # @return [Number] The maximum rate
      # @see #rate
      
      def maximum_rate
        player_iface['MaximumRate']
      end
      
      # Whether the client can call the {#next} method on this interface and
      # expect the current track to change.
      #
      # If it is unknown whether a call to {#next} will be successful (for
      # example, when streaming tracks), this property would be set to true.
      #
      # If {#can_control?} is false, this property would also be false.
      # @return [Boolean]
      # @see #next
      # @see #can_control?
      
      def can_go_next?
        player_iface['CanGoNext']
      end
      
      # Whether the client can call the {#previous} method on this interface and
      # expect the current track to change.
      #
      # If it is unknown whether a call to {#previous} will be successful (for
      # example, when streaming tracks), this property would be set to true.
      #
      # If {#can_control?} is false, this property would also be false.
      # @return [Boolean]
      # @see #previous
      # @see #can_control?
      
      def can_go_previous?
        player_iface['CanGoPrevious']
      end

      # Whether playback can be started using {#play} or {#play_pause}.
      #
      # Note that this is related to whether there is a "current track": the
      # value should not depend on whether the track is currently paused or
      # playing. In fact, if a track is currently playing (and {#can_control?} is
      # true), this should be true.
      #
      # If {#can_control?} is false, this property would also be false.
      # @return [Boolean]
      # @see #play
      # @see #play_pause
      # @see #can_control?
      
      def can_play?
        player_iface['CanPlay']
      end

      # Whether playback can be paused using {#pause} or {#play_pause}.
      #
      # Note that this is an intrinsic property of the current track: its value
      # should not depend on whether the track is currently paused or playing.
      # In fact, if playback is currently paused (and {#can_control?} is true),
      # this should be true.
      #
      # If {#can_control?} is false, this property would also be false.
      # @return [Boolean]
      # @see #pause
      # @see #play_pause
      # @see #can_control?

      def can_pause?
        player_iface['CanPause']
      end

      # Whether the client can control the playback position using {#seek} and
      # {#set_position}. This may be different for different tracks.
      #
      # If {#can_control?} is false, this property would also be false.
      # @return [Boolean]
      # @see #seek
      # @see #set_position
      # @see #can_control?
      
      def can_seek?
        player_iface['CanSeek']
      end
      
      # Whether the media player may be controlled over this interface.
      #
      # This property is not expected to change, as it describes an intrinsic
      # capability of the implementation.
      # If this is false, clients should assume that all properties on this
      # interface are read-only (and will raise errors if writing to them is
      # attempted), no methods are implemented and all other properties starting
      # with "can_" are also false.
      # @return [Boolean]
      
      def can_control?
        player_iface['CanControl']
      end

      def on_playback_status_changed( &block )
        on_property_changed 'PlaybackStatus', &block
      end
      
      def on_loop_status_changed( &block )
        on_property_changed 'LoopStatus', &block
      end
      
      def on_shuffle_changed( &block )
        on_property_changed 'Shuffle', &block
      end
      
      def on_metadata_changed( &block )
        on_property_changed 'Metadata', &block
      end
      
      def on_rate_changed( &block )
        on_property_changed 'Rate', &block
      end
      
      def on_volume_changed( &block )
        on_property_changed 'Volume', &block
      end
      
      def on_position_changed( &block )
        on_property_changed 'Position', &block
      end
      
      def on_minimum_rate_changed( &block )
        on_property_changed 'MinimumRate', &block
      end
      
      def on_maximum_rate_changed( &block )
        on_property_changed 'MaximumRate', &block
      end
      
      def on_can_go_next_changed( &block )
        on_property_changed 'CanGoNext', &block
      end
      
      def on_can_go_previous_changed( &block )
        on_property_changed 'CanGoPrevious', &block
      end
      
      def on_can_play_changed( &block )
        on_property_changed 'CanPlay', &block
      end
      
      def on_can_pause_changed( &block )
        on_property_changed 'CanPause', &block
      end
      
      def on_can_seek_changed( &block )
        on_property_changed 'CanSeek', &block
      end
      
      def on_can_control_changed( &block )
        on_property_changed 'CanControl', &block
      end
      
      private
      
      def player_iface
        iface PLAYER_IFACE_NAME
      end

    end
  end
end
