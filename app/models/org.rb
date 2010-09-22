class Org < ActiveRecord::Base
  has_one :org_owner
  accepts_nested_attributes_for :org_owner
  
  validates_presence_of :name, :description, :gender, :min_age, :max_age
end