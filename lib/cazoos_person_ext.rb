module CazoosPersonExt
  
  def self.included(base)
    base.extend(ClassMethods)
  end
  
  module ClassMethods
    def cazoos_person_extra_methods      
      include CazoosPersonExt::InstanceMethods
    end
  end
  
  module InstanceMethods
    def admin?
      person_groups.include?(PersonGroup.find_by_title('Admin'))
    end
  end
  
end
ActiveRecord::Base.send(:include, CazoosPersonExt)
Person.send(:cazoos_person_extra_methods)