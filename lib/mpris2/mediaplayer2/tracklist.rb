class MPRIS2
  class MediaPlayer2
  
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
