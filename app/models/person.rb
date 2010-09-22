class Person < ActiveRecord::Base
  require "#{RAILS_ROOT}/vendor/plugins/siteninja/siteninja_core/app/models/person"
  attr_accessor :email_confirmation
  
  validates_confirmation_of :email, :if => :email_changed?
end