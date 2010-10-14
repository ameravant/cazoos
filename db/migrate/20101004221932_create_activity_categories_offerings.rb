class CreateActivityCategoriesOfferings < ActiveRecord::Migration
  def self.up
    create_table :activity_categories_offerings, :id => false do |t|
      t.integer :offering_id, :activity_category_id
    end
  end

  def self.down
    drop_table :activity_categories_offerings
  end
end
