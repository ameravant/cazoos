namespace :admin do |admin|
  # admin.resources :orgs, :as => 'organizations', :except => :show
  admin.resources :orgs, :as => 'organizations', :except => :show do |org|
    org.resources :activities, :only => [:new, :create, :index]
  end
  admin.resources :org_types, :as => 'organization_types', :except => :show
  admin.resources :activity_categories, :except => :show
  admin.resources :activities, :only => [:edit, :update, :destroy, :index]
  admin.resources :children
end
