Factory.define :user do |f|
  f.sequence(:username) { |n| "foo#{n}"}
  f.password "secret"
  f.password_confirmation { |u| u.password }
  f.sequence(:email) { |n| "foo#{n}@example.com" }
end

Factory.define :super_user, :class => User do |f|
  f.username "admin"
  f.password "admin"
  f.password_confirmation "admin"
  f.email "admin@admin.com"
end

Factory.define :org do |f|
  f.association :person
  f.name "Camp Something"
  f.description "Camp Something has many things, none of which are in this description."
  f.blurb "Providing something for your kids"
  f.min_age "1"
  f.max_age "100"
  f.gender "coed"
  f.contact "Mr. Contact"
  f.contact_phone "800-555-CAMP"
  f.contact_email "contact@campsomething.com"
  f.address "1234 Any Street"
  f.city "Santa Barbara"
  f.state "CA"
  f.zip "93101"
end

Factory.define :person do |f|
  f.first_name 'Orgo'
  f.last_name 'Owner'
  f.sequence(:email) { |n| "owner#{n}@org.com" }
  f.phone '805-234-1234'
  f.address1 '555 Main St.'
  f.city 'Santa Maria'
  f.state 'CA'
  f.zip '93203'
end