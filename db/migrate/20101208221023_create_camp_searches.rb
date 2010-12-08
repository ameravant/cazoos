class CreateCampSearches < ActiveRecord::Migration
  def self.up
    create_table :camp_searches do |t|
      t.integer :age

      t.timestamps
    end
  end

  def self.down
    drop_table :camp_searches
  end
end
