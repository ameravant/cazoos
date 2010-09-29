class CreateActivityCategories < ActiveRecord::Migration
  def self.up
    create_table :activity_categories do |t|
      t.string :name, :permalink
      t.text :description, :blurb

      t.timestamps
    end
  end

  def self.down
    drop_table :activity_categories
  end
end
