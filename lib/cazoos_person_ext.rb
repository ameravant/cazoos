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
      respond_to?(:user) && user.is_admin
    end
    def full_name
      first_name + ' ' + last_name
    end
  end

end
ActiveRecord::Base.send(:include, CazoosPersonExt)
Parent.send(:cazoos_person_extra_methods)
OrgOwner.send(:cazoos_person_extra_methods)
Child.send(:cazoos_person_extra_methods)
Person.send(:cazoos_person_extra_methods)