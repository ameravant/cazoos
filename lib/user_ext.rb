module UserExt
  
  def self.included(base)
    base.extend(ClassMethods)
  end
  
  module ClassMethods
    def extra_methods
      include UserExt::InstanceMethods
    end
  end
  
  module InstanceMethods
    def is_super_user?
      self.has_role(:super_user)
      # temporary for purposes of testing
      self.login == 'admin'
    end
  end
  
end
ActiveRecord::Base.send(:include, UserExt)
User.send(:extra_methods)