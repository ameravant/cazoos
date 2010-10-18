class AddOfferingIdToEvents < ActiveRecord::Migration
  def self.up
    add_column :events, :offering_id, :integer
  end

  def self.down
    remove_column :events, :offering_id
  end
end
