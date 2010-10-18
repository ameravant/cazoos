module CazoosEventExt

  def self.included(base)
    base.extend(ClassMethods)
  end
  
  module ClassMethods
    def cazoos_event_extra_methods
      belongs_to :offering
      
      def new_offering(off, atts = {})
        Event.new( 
          { :name => off.name, 
            :description => off.description, 
            :address => off.org.map_address
          }.merge(atts)
        )
      end
      
      include CazoosEventExt::InstanceMethods
    end
  end
  
  module InstanceMethods
  end
  
end
ActiveRecord::Base.send(:include, CazoosEventExt)
Event.send(:cazoos_event_extra_methods)