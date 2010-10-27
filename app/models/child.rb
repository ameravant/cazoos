class Child < Person
  belongs_to :parent
  before_validation :validates_existence_of_parent
  
  protected
  
  def validates_existence_of_parent
    begin
      Parent.find(self.parent_id)
    rescue ActiveRecord::RecordNotFound
      self.errors.add :parent_id, 'must be registered as a parent in the system'
      false
    end
  end
end