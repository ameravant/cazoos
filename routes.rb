namespace :admin do |admin|
  admin.resources :orgs, :as => 'organizations', :except => :show
  admin.resources :org_types, :as => 'organization_types', :except => :show
  admin.resources :activity_categories, :except => :show
  admin.resources :activities, :except => :show
end