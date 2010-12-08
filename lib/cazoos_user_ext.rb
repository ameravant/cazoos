module CazoosUserExt
  
  def self.included(base)
    base.extend(ClassMethods)
    # User.class_eval do
    #       alias_method :old_has_role, :has_role   
    #     end
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
    
    # def has_role(jason)
    #   if self.login.blank? #role == self.class.table_name.singularize
    #     puts "its blank"
    #   else
    #     puts "nope"
    #   end
    #   old_has_role
    #   # true unless (self.person.person_groups.find(:first, :conditions => {:title => role})).blank?
    # end
    
    def is_a?(klass)
      super(klass) || (respond_to?(:person) && person.is_a?(klass))
    end
  end
  
end
# ActiveRecord::Base.send(:include, CazoosUserExt)
# User.send(:include, CazoosUserExt::InstanceMethods)
# User.send(:cazoos_user_extra_methods)