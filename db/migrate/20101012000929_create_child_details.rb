class CreateChildDetails < ActiveRecord::Migration
  def self.up
    create_table :child_details do |t|
      t.integer :child_id
      t.string :first_name
      t.string :last_name
      t.date :birthday
      t.string :height
      t.boolean :gender
      t.integer :weight
      t.string :school
      t.string :allergies
      t.string :family_doc
      t.string :doc_phone
      t.string :insurance_car
      t.string :policy_num
      t.string :policy_name
      t.timestamps
    end
  end

  def self.down
    drop_table :child_details
  end
end
