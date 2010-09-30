class AddOrgTypeIdToOrgs < ActiveRecord::Migration
  def self.up
    add_column :orgs, :org_type_id, :integer
  end

  def self.down
    remove_column :orgs, :org_type_id
  end
end
