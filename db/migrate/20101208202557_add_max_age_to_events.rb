class AddMaxAgeToEvents < ActiveRecord::Migration
  def self.up
    add_column :events, :max_age, :integer
    add_column :events, :min_age, :integer
  end

  def self.down
    remove_column :events, :min_age
    remove_column :events, :max_age
  end
end
