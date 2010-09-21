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
  f.name "Camp Something"
  f.description "Camp Something has many things, none of which are in this description."
  f.blurb "Providing something for your kids"
  f.min_age "1"
  f.max_age "100"
end

Factory.define :org_owner do |f|
  f.first_name 'Orgo'
  f.last_name 'Owner'
  f.email 'owner@org.com'
end