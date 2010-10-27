class OrgOwner < Person
  has_one :org, :foreign_key => :owner_id
end
