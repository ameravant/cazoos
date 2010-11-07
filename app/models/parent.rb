class Parent < Person
  has_many :children
  
  validates_format_of :phone, :with => /^1?([\d][-\(\)]?){10}$/, :message => 'must be a valid ten-digit phone number'
  validates_presence_of :address1, :city, :state, :zip
end
