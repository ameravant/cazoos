module CazoosUserExt
  
  def self.included(base)
    base.extend(ClassMethods)
  end
  
  module ClassMethods
    def cazoos_user_extra_methods      
      include CazoosUserExt::InstanceMethods
    end
  end
  
  module InstanceMethods
    def admin?
      is_admin
    end
    
    def is_a?(klass)
      super(klass) || (respond_to?(:person) && person.is_a?(klass))
    end
  end
  
end
ActiveRecord::Base.send(:include, CazoosUserExt)
User.send(:cazoos_user_extra_methods)