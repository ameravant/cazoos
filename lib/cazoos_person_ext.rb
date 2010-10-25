module CazoosPersonExt
  
  def self.included(base)
    base.extend(ClassMethods)
  end
  
  module ClassMethods
    def cazoos_person_extra_methods
      has_many :children
      include CazoosPersonExt::InstanceMethods
    end
  end
  
  module InstanceMethods
    # def after_find: "should not allow a person in the system to belong to more than one group"
    # I chose after_find b/c it was difficult to intercept the << operator, so this resets every time the person is found
    def after_find
      pgs = self.person_groups
      if pgs.size > 1
        self.person_groups = [ pgs[0] ]
        self.save
      end
    end
  end
  
end
ActiveRecord::Base.send(:include, CazoosPersonExt)
Person.send(:cazoos_person_extra_methods)