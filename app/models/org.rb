class Org < ActiveRecord::Base
  belongs_to :owner, :class_name => 'Person'
  belongs_to :org_type
  # accepts_nested_attributes_for :person

  validates_presence_of :owner_id
  validates_associated :owner

  validates_presence_of :org_type_id
  validates_associated :org_type
  
  validates_presence_of :name, :description, :gender, :min_age, :max_age, :address, :city, :state, :zip
  validates_presence_of :contact, :contact_phone, :contact_email
  
  validates_numericality_of :min_age, :only_integer => true, :message => 'must be a whole number'
  validates_numericality_of :max_age, :only_integer => true, :message => 'must be a whole number'
  
  before_save :validates_ages
  
  def map_address
    "#{self.address}, #{self.city}, #{self.state} #{self.zip}"
  end
  
  private
  
  def validates_ages
    valid_ages = self.min_age.to_i <= self.max_age.to_i
    self.errors.add :min_age, 'must be less than Max Age' if !valid_ages
    valid_ages
  end
end