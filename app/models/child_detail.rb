class ChildDetail < ActiveRecord::Base
  belongs_to :child
  before_validation :validates_birthday
  validates_presence_of :birthday, :gender
  
  protected
  
  def validates_birthday
    if !birthday.blank? && birthday.to_date > Time.now.to_date
      errors.add(:birthday, 'must be before now')
      false
    end
  end
end