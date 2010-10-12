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
  end
  
end
ActiveRecord::Base.send(:include, CazoosPersonExt)
Person.send(:cazoos_person_extra_methods)