class Activity < ActiveRecord::Base
  has_and_belongs_to_many :activity_categories
  
  validates_presence_of :name, :description
end