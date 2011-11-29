class MPRIS2
  class MediaPlayer2
  
    # Provides access to a short list of tracks which were recently played or
    # will be played shortly. This is intended to provide context to the
    # currently-playing track, rather than giving complete access to the media
    # player's playlist.
    #
    # Example use cases are the list of tracks from the same album as the
    # currently playing song or the Rhythmbox play queue.
    #
    # Each track in the tracklist has a unique identifier. The intention is that
    # this uniquely identifies the track within the scope of the tracklist. In
    # particular, if a media item (a particular music file, say) occurs twice in
    # the track list, each occurrence should have a different identifier. If a
    # track is removed from the middle of the playlist, it should not affect the
    # track ids of any other tracks in the tracklist.
    #
    # As a result, the traditional track identifiers of URLs and position in the
    # playlist cannot be used. Any scheme which satisfies the uniqueness
    # requirements is valid, as clients should not make any assumptions about
    # the value of the track id beyond the fact that it is a unique identifier.
    #
    # Note that the (memory and processing) burden of implementing the TrackList
    # interface and maintaining unique track ids for the playlist can be
    # mitigated by only exposing a subset of the playlist when it is very long
    # (the 20 or so tracks around the currently playing track, for example).
    # This is a recommended practice as the tracklist interface is not designed
    # to enable browsing through a large list of tracks, but rather to provide
    # clients with context about the currently playing track.
    #
    # @see http://www.mpris.org/2.1/spec/TrackList_Node.html
  
    module TrackList
    
      # D-Bus interface name for TrackList
    
      TRACK_LIST_IFACE_NAME = 'org.mpris.MediaPlayer2.TrackList'

      # GetTracksMetadata	(ao: TrackIds)	→	aa{sv}: Metadata	

      def get_tracks_metadata( track_ids )
        track_list_iface.GetTracksMetadata track_ids
      end

      # AddTrack	(s: Uri, o: AfterTrack, b: SetAsCurrent)	→	nothing	
      
      def add_track( uri, after_track, set_as_current )
        track_list_iface.AddTrack uri, after_track, set_as_current
      end
      
      # RemoveTrack	(o: TrackId)	→	nothing	
      
      def remove_track( track_id )
        track_list_iface.RemoveTrack track_id
      end
      
      # GoTo	(o: TrackId)	→	nothing
      
      def go_to( track_id )
        track_list_iface.GoTo track_id
      end
      
      # TrackListReplaced	(ao: Tracks, o: CurrentTrack)	
      
      def on_track_list_replaced( &block )
        track_list_iface.on_signal @object.bus, 'TrackListReplaced', &block
      end
      
      # TrackAdded	(a{sv}: Metadata, o: AfterTrack)	
      
      def on_track_added( &block )
        track_list_iface.on_signal @object.bus, 'TrackAdded', &block
      end
      
      # TrackRemoved	(o: TrackId)	
      
      def on_track_removed( &block )
        track_list_iface.on_signal @object.bus, 'TrackRemoved', &block
      end
      
      # TrackMetadataChanged	(o: TrackId, a{sv}: Metadata)
      
      def on_track_metadata_changed( &block )
        track_list_iface.on_signal @object.bus, 'TrackMetadataChanged', &block
      end

      # Tracks	 ao (Track_Id_List)	Read only
      
      def tracks
        track_list_iface['Tracks']
      end
      
      #CanEditTracks	 b	Read only	
      
      def can_edit_tracks?
        track_list_iface['CanEditTracks']
      end
      
      def on_tracks_changed( &block )
        on_property_changed 'Tracks', &block
      end
      
      def on_can_edit_tracks_changed( &block )
        on_property_changed 'CanEditTracks', &block
      end
    
      private
      
      def track_list_iface
        iface TRACK_LIST_IFACE_NAME
      end

    end
  end
end
