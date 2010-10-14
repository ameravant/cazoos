class CreateOfferings < ActiveRecord::Migration
  def self.up
    create_table :offerings do |t|
      t.integer :org_id
      t.string :name
      t.text :description
      
      t.timestamp
    end
  end

  def self.down
    drop_table :offerings
  end
end
