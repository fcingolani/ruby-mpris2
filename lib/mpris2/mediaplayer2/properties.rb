class MPRIS2
  class MediaPlayer2
    module Properties
    
      PROPERTIES_IFACE_NAME = 'org.freedesktop.DBus.Properties'

      def on_properties_changed( &block )
        on_property_changed 'PropertiesChanged', &block
      end
      
      private
      
      def on_property_changed( property, &block )
        if @property_change_handlers.nil? then
          @property_change_handlers = Hash.new
          properties_iface.on_signal @object.bus, 'PropertiesChanged', &method(:handle_properties_changed)
        end
        @property_change_handlers[property] = block
      end
      
      def handle_properties_changed( iface_name, changed_properties, invalidated_properties )
        if @property_change_handlers.key?('PropertiesChanged')
          @property_change_handlers['PropertiesChanged'].call( iface_name, changed_properties, invalidated_properties )
        end
      
        changed_properties.each do | property, value |
          if @property_change_handlers.key?(property)
            @property_change_handlers[property].call( value )
          end
        end
      end
      
      def properties_iface
        @object[PROPERTIES_IFACE_NAME]
      end
    
    end
  end
end
