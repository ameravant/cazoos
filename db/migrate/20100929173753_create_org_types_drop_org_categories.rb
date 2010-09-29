class CreateOrgTypesDropOrgCategories < ActiveRecord::Migration
  def self.up
    create_table :org_types do |t|
      t.string :title, :permalink
      t.text :description
      
      t.timestamps
    end

    drop_table :org_categories
    
  end

  def self.down
    create_table :org_categories do |t|
      t.string :title, :permalink
      
      t.timestamps
    end

    drop_table :org_types
    
  end
end
