class CreateOrgs < ActiveRecord::Migration
  def self.up
    create_table :orgs do |t|
      t.string :name
      t.text :description
      t.text :blurb
      t.string :gender
      t.integer :min_age
      t.integer :max_age

      t.timestamps
    end
  end

  def self.down
    drop_table :orgs
  end
end
