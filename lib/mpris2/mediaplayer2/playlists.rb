class MPRIS2
  class MediaPlayer2
  
    # @see http://www.mpris.org/2.1/spec/Playlists_Node.html
  
    module Playlists
    
      # D-Bus interface name for TrackList
    
      PLAYLISTS_IFACE_NAME = 'org.mpris.MediaPlayer2.Playlists'

      # ActivatePlaylist	(o: PlaylistId)	→	nothing	
      
      def activate_playlist( playlist_id )
        playlists_iface.ActivatePlaylist playlist_id
      end
      
      # GetPlaylists	(u: Index, u: MaxCount, s: Order, b: ReverseOrder)	→	a(oss): Playlists	
      
      def get_playlists( index, max_count, order, reverse_order )
        playlists_iface.GetPlaylists index, max_count, order, reverse_order
      end
      
      # PlaylistChanged	((oss): Playlist)	
      
      def on_playlist_changed( &block )
        playlists_iface.on_signal @object.bus, 'PlaylistChanged', &block
      end
      
      # PlaylistCount	 u	Read only		
      
      def playlist_count
        playlists_iface['PlaylistCount']
      end
      
      # Orderings	 as (Playlist_Ordering_List)	Read only		
      
      def orderings
        playlists_iface['Orderings']
      end
      
      # ActivePlaylist	 (b(oss)) (Maybe_Playlist)	Read only	
      
      def active_playlist
        playlists_iface['ActivePlaylist']
      end
      
      def on_playlist_count_changed( &block )
        on_property_changed 'PlaylistCount', &block
      end
      
      def on_orderings_tracks_changed( &block )
        on_property_changed 'Orderings', &block
      end
      
      def on_active_playlist_changed( &block )
        on_property_changed 'ActivePlaylist', &block
      end
    
      private
      
      def playlists_iface
        iface PLAYLISTS_IFACE_NAME
      end

    end
  end
end
