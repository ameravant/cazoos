namespace :admin do |admin|
  admin.resources :orgs, :as => 'organizations'
  admin.resources :org_categories, :as => 'organization_categories'
end