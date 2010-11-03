Factory.define :user do |f|
  f.sequence(:login) { |n| "foo#{n}"}
  f.password "secret"
  f.password_confirmation { |u| u.password }
end

Factory.define :org do |f|
  f.association :owner, :factory => :org_owner
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

Factory.define :super_user_person, :class => 'Person' do |f|
  f.association :user, :factory => :super_user
  f.person_group_ids [ PersonGroup.find_by_title('Admin').id ]
  f.sequence(:first_name) { |n| "Minnie#{n}"}
  f.last_name 'Straytor'
  f.sequence(:email) { |n| "admin#{n}@org.com" }
  f.phone '805-234-1234'
  f.address1 '555 Main St.'
  f.city 'Santa Barbara'
  f.state 'CALIFORNIA'
  f.zip '93203'
end

Factory.define :super_user, :class => 'User' do |f|
  f.sequence(:login) { |n| "foo#{n}"}
  f.password "secret"
  f.password_confirmation { |u| u.password }
  f.is_admin true
end

Factory.define :parent do |f|
  f.association :user
  f.sequence(:first_name) { |n| "John#{n}"}
  f.last_name 'Adams'
  f.sequence(:email) { |n| "parent#{n}@blah.com" }
  f.phone '805-234-1234'
  f.address1 '555 Main St.'
  f.city 'Santa Barbara'
  f.state 'CALIFORNIA'
  f.zip '93203'
end

Factory.define :child do |f|
  f.association :user
  f.association :parent
  f.sequence(:first_name) { |n| "Little Jimmy#{n}" }
  f.last_name 'Adams'
#  f.sequence(:email) { |n| "child#{n}@blah.com" }
  f.phone ''
  f.address1 ''
  f.city ''
  f.state ''
  f.zip ''
  # f.after_build { |a| Factory.build(:detail) }
end

Factory.define :child_detail do |f|
  f.association :child
  f.birthday '1998-10-11'
  f.height '4.2'
  f.gender 'boy'
  f.weight '300'
  f.school 'Valley View'
  f.allergies 'everything'
  f.family_doc 'Dr. Bob'
  f.doc_phone '800-666-8888'
  f.insurance_car 'kaiser'
  f.policy_num "123"
  f.policy_name 'cheapy'  
end

Factory.define :org_owner do |f|
  f.association :user
  f.sequence(:first_name) { |n| "Orgo#{n}" }
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

Factory.define :offering do |f|
  f.association :org
  f.sequence(:name) { |n| "Activity#{n}" }
  f.description "Description of this Activity"
end

Factory.define :event do |e|
  e.association :offering
	e.name 'Event Name'
	# e.permalink string
	e.address '1624 Olive St., Santa Barbara, CA 93101'
	e.description 'Description of Event'
	e.date_and_time '2010-11-01 09:00:00'
	# e.person_id integer
	e.images_count 0
	e.features_count 0
	e.assets_count 0
	e.registration_limit 3
	e.payment_instructions 'Pay now, play later'
	e.registration_closed_text 'Sorry. This camp session is full.'
	e.blurb 'Meets each day at 9am.  Campers should have their own snorkeling gear, or you can call us to arrange something.'
	e.registration true
	# e.allow_cash boolean
	# e.allow_check boolean
	# e.allow_other boolean
	e.allow_card true
	e.allow_credit_card true
	# e.check_instructions text
	e.end_date_and_time '2010-11-05 12:00:00'
	e.registration_deadline '2010-10-18 11:59:59'
	# e.master_group_id integer
end
