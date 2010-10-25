Factory.define :user do |f|
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
  f.association :owner
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

Factory.define :parent, :class => Person do |f|
  f.association :user
  f.person_group_ids [PersonGroup.find_by_title('Parent')]
  f.sequence(:first_name) { |n| "John#{n}"}
  f.last_name 'Adams'
  f.sequence(:email) { |n| "parent#{n}@blah.com" }
  f.phone '805-234-1234'
  f.address1 '555 Main St.'
  f.city 'Santa Barbara'
  f.state 'CALIFORNIA'
  f.zip '93203'
end

Factory.define :child, :class => Child do |f|
  f.association :parent
  f.sequence(:first_name) { |n| "John#{n}"}
  f.last_name 'Adams'
  f.birthday '1990-10-11'
  f.height '4.2'
  f.gender true
  f.weight '300'
  f.school 'Valley View'
  f.allergies 'everything'
  f.family_doc 'Dr death'
  f.doc_phone '900-000-0000'
  f.insurance_car 'kaiser'
  f.policy_num "123"
  f.policy_name 'cheapy'  
end

Factory.define :owner, :class => Person do |f|
  f.association :user
  f.person_group_ids [PersonGroup.find_by_title('Organization Owner')]
  f.sequence(:first_name) { |n| "Orgo#{n}"}
  f.last_name 'Owner'
  f.sequence(:email) { |n| "owner#{n}@org.com" }
  f.phone '805-234-1234'
  f.address1 '555 Main St.'
  f.city 'Santa Maria'
  f.state 'CA'
  f.zip '93203'
end

# Factory.define :person do |f|
#   f.sequence(:first_name) { |n| "Person#{n}"}
#   f.last_name 'Smith'
#   f.sequence(:email) { |n| "person#{n}@org.com" }
#   f.phone '805-234-1234'
#   f.address1 '555 Main St.'
#   f.city 'Santa Maria'
#   f.state 'CA'
#   f.zip '93203'
# end

Factory.define :org_type do |f|
  f.sequence(:title) { |n| "Organization Type #{n}" }
  f.sequence(:description) { |n| "Description of Type #{n}" }
end

Factory.define :activity_category do |f|
  f.sequence(:name) { |n| "Category #{n}" }
  f.description "Description of this category"
  f.blurb "Blurb about this category"
end

Factory.define :activity do |f|
  f.association :org
  f.sequence(:name) { |n| "Activity#{n}" }
  f.description "Description of this Activity"
end