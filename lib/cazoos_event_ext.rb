module CazoosEventExt

  def self.included(base)
    base.extend(ClassMethods)
  end
  
  module ClassMethods
    def cazoos_event_extra_methods
      belongs_to :offering
      before_validation :validates_existence_of_offering
      validates_numericality_of :registration_limit, :only_integer => true, 
        :message => 'must be a whole number', :if => :registration
      
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
    
    private
    
    def validates_existence_of_offering
      begin
        Offering.find(self.offering_id)
      rescue ActiveRecord::RecordNotFound
        self.errors.add :offering_id, 'must belong to an offering'
        false
      end
      # This also would work; not sure which is a better practice, although I think the find_by_id method may get
      #   created on the fly, which would make it slower???
      # offering_exists = !Offering.find_by_id(self.offering_id).nil?
      # self.errors.add :offering_id, 'must belong to an offering' if !offering_exists
      # offering_exists
    end
  end
  
end
ActiveRecord::Base.send(:include, CazoosEventExt)
Event.send(:cazoos_event_extra_methods)
