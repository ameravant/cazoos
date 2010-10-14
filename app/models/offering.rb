class Offering < ActiveRecord::Base
  has_and_belongs_to_many :activity_categories
  belongs_to :org
  
  validates_presence_of :name, :description, :org_id
  validates_associated :org
end
