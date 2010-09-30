Factory.define :user do |f|
  f.association :person
  f.sequence(:login) { |n| "foo#{n}"}
  f.password "secret"
  f.password_confirmation { |u| u.password }
end

Factory.define :super_user, :class => User do |f|
  f.login "admin"
  f.password "admin"
  f.password_confirmation "admin"
end

Factory.define :org do |f|
  f.association :person
  f.association :org_type
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
  f.sequence(:first_name) { |n| "Orgo#{n}"}
  f.last_name 'Owner'
  f.sequence(:email) { |n| "owner#{n}@org.com" }
  f.phone '805-234-1234'
  f.address1 '555 Main St.'
  f.city 'Santa Maria'
  f.state 'CA'
  f.zip '93203'
end

Factory.define :org_type do |f|
  f.sequence(:title) { |n| "Organization Type #{n}" }
  f.sequence(:description) { |n| "Description of Type #{n}" }
end

Factory.define :activity_category do |f|
  f.sequence(:name) { |n| "Category #{n}" }
  f.description "Description of this category"
  f.blurb "Blurb about this category"
end