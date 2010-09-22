class Org < ActiveRecord::Base
  has_one :org_owner
  accepts_nested_attributes_for :org_owner
end