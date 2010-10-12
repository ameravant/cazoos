class Person < ActiveRecord::Base
  require "#{RAILS_ROOT}/vendor/plugins/siteninja/siteninja_core/app/models/person.rb"
  has_many :children
end