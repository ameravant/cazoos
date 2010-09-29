class ActivityCategory < ActiveRecord::Base
  has_permalink :name
  validates_presence_of :name, :description
end