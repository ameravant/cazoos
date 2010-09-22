class OrgOwner < Person
  attr_accessor :email_confirmation
  
  validates_confirmation_of :email, :if => :email_changed?
end