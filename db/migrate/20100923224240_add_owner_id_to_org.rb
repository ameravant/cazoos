class AddOwnerIdToOrg < ActiveRecord::Migration
  def self.up
    add_column :orgs, :owner_id, :integer
  end

  def self.down
    remove_column :orgs, :owner_id
  end
end
