module CazoosEventExt

  def self.included(base)
    base.extend(ClassMethods)
  end
  
  module ClassMethods
    def cazoos_event_extra_methods
      belongs_to :offering
      
      validates_presence_of :description, :end_date_and_time, :registration_deadline, :offering_id
      validates_numericality_of :registration_limit, :only_integer => true, 
        :message => 'must be a whole number', :allow_nil => true
      
      def new_offering(off, atts = {})
        Event.new( 
          { :name => off.name, 
            :description => off.description, 
            :address => off.org.map_address,
            :offering => off
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