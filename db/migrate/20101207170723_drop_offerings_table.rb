class DropOfferingsTable < ActiveRecord::Migration
  def self.up
    drop_table :offerings
    drop_table :activity_categories_offerings
  end

  def self.down
    create_table :offerings do |t|
      t.integer :org_id
      t.string :name
      t.text :description
      t.timestamp
    end
    create_table :activity_categories_offerings, :id => false do |t|
      t.integer :offering_id, :activity_category_id
    end
  end
end
