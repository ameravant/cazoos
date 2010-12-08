class AddPermalinkToOrgs < ActiveRecord::Migration
  def self.up
    add_column :orgs, :permalink, :string
  end

  def self.down
    remove_column :orgs, :permalink
  end
end
