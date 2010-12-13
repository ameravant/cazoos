class AddOrgIdToEvents < ActiveRecord::Migration
  def self.up
    add_column :events, :org_id, :integer
  end

  def self.down
    remove_column :events, :org_id
  end
end
