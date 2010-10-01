class CreateActivities < ActiveRecord::Migration
  def self.up
    create_table :activities do |t|
      t.integer :org_id
      t.string :name
      t.text :description
      
      t.timestamp
    end
  end

  def self.down
    drop_table :activities
  end
end
