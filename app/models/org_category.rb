class OrgCategory < ActiveRecord::Base
  has_permalink :title

  before_validation :no_new_permalink_allowed  
  validates_presence_of :title
  
  private
  
  def no_new_permalink_allowed
    self.errors.add(:permalink, 'cannot change') if self.permalink_changed? && !self.new_record?
    !(self.permalink_changed? && !self.new_record?)
  end
end