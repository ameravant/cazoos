Factory.define :user do |f|
  f.sequence(:username) { |n| "foo#{n}"}
  f.password "secret"
  f.password_confirmation { |u| u.password }
  f.sequence(:email) { |n| "foo#{n}@example.com" }
end

