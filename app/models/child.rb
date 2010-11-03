class Child < Person
  belongs_to :parent
  has_one :detail, :class_name => 'ChildDetail'
  before_validation :validates_existence_of_parent_and_assign_email
  accepts_nested_attributes_for :detail
  
  protected
  
  def validates_existence_of_parent_and_assign_email
    begin
      parent = Parent.find(self.parent_id)
      self.email = "#{self.first_name.gsub(/[^A-Za-z0-9]/,'')}-#{parent.email}"
    rescue ActiveRecord::RecordNotFound
      self.errors.add :parent_id, 'must be registered as a parent in the system'
      false
    end
  end

end