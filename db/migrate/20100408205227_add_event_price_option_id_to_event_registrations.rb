class AddEventPriceOptionIdToEventRegistrations < ActiveRecord::Migration
  def self.up
    add_column :event_registrations, :event_price_option_id, :integer
  end

  def self.down
    remove_column :event_registrations, :event_price_option_id
  end
end
