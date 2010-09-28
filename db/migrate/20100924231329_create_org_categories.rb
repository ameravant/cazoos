class CreateOrgCategories < ActiveRecord::Migration
  def self.up
    create_table :org_categories do |t|
      t.string :title, :permalink
      
      t.timestamps
    end
  end

  def self.down
    drop_table :org_categories
  end
end
