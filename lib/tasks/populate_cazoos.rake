namespace :db do
  task :populate_cazoos => :environment do

    admin = PersonGroup.create(:title => "Admin", :role => true, :public => false, :description => "Has access to all areas of the CMS.")
    org_owner = PersonGroup.create(:title => "Organization Owner", :role => true, :public => false, :description => "Can login and manage his/her camp, camp offerings and schedules")
    parent = PersonGroup.create(:title => "Parent", :role => true, :public => false, :description => "A parent with children in the Cazoos system")
    child = PersonGroup.create(:title => "Child", :role => true, :public => false, :description => "A child in the system")

    # Create admin user here (SuperAdmin privileges)
    person = Person.create(:first_name => "admin", :last_name => "admin", :email => "admin@mailinator.com")
    person.person_groups << admin
    user = User.create(:login => 'admin', :password => 'admin', :password_confirmation => 'admin', :active => true)
    user.person_id = person.id
    user.save
  end
end
