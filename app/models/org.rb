class Org < ActiveRecord::Base
  has_one :org_owner
  accepts_nested_attributes_for :org_owner
  
  validates_presence_of :name, :description, :gender, :min_age, :max_age
  validates_numericality_of :min_age, :only_integer => true, :message => 'must be a whole number'
  
  before_save :validates_ages
  
  
  private
  
  def validates_ages
    valid_ages = self.min_age.to_i <= self.max_age.to_i
    self.errors.add :min_age, 'must be less than Max Age' if !valid_ages
    valid_ages
  end
end