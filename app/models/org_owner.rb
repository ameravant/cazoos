class OrgOwner < Person
  has_one :org, :foreign_key => :owner_id
  accepts_nested_attributes_for :user
end
