class Offering < ActiveRecord::Base
  has_and_belongs_to_many :activity_categories
  belongs_to :org
  has_many :events
  
  validates_presence_of :name, :description, :org_id
  validates_associated :org
  
  # def initialize(*args)
  #   super(*args)
  #   
  #   # self.name = Org.find(self.org_id).name if !self.org_id.nil?
  #   puts self.org_id
  # end
end