module CazoosEventExt

  def self.included(base)
    base.extend(ClassMethods)
  end
  
  module ClassMethods
    def cazoos_event_extra_methods
      belongs_to :org
      validates_numericality_of :registration_limit, :only_integer => true, 
        :message => 'must be a whole number', :if => :registration
      validates_associated :org
      include CazoosEventExt::InstanceMethods
    end
  end
  
  module InstanceMethods

      # This also would work; not sure which is a better practice, although I think the find_by_id method may get
      #   created on the fly, which would make it slower???
      # offering_exists = !Offering.find_by_id(self.offering_id).nil?
      # self.errors.add :offering_id, 'must belong to an offering' if !offering_exists
      # offering_exists
  end
  
end
ActiveRecord::Base.send(:include, CazoosEventExt)
Event.send(:cazoos_event_extra_methods)
