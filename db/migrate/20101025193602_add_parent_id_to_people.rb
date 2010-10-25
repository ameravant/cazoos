class AddParentIdToPeople < ActiveRecord::Migration
  def self.up
    add_column :people, :parent_id, :integer
  end

  def self.down
    remove_column :people, :parent_id
  end
end
