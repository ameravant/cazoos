class AddFieldsToOrg < ActiveRecord::Migration
  def self.up
    add_column :orgs, :contact, :string
    add_column :orgs, :contact_phone, :string
    add_column :orgs, :address, :string
    add_column :orgs, :city, :string
    add_column :orgs, :state, :string
    add_column :orgs, :zip, :string
    add_column :orgs, :contact_email, :string
  end

  def self.down
    remove_column :orgs, :contact_email
    remove_column :orgs, :zip
    remove_column :orgs, :state
    remove_column :orgs, :city
    remove_column :orgs, :address
    remove_column :orgs, :contact_phone
    remove_column :orgs, :contact
  end
end
