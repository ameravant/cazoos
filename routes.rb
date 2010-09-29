namespace :admin do |admin|
  admin.resources :orgs, :as => 'organizations'
  admin.resources :org_types, :as => 'organization_types'
  admin.resources :activity_categories
end