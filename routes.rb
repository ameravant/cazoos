namespace :admin do |admin|
  admin.resources :orgs, :as => 'organizations' do |org|
    org.resources :offerings, :only => [:new, :create, :index, :edit, :update]
  end
  admin.resources :org_types, :as => 'organization_types', :except => :show
  admin.resources :activity_categories, :only => [:new, :create, :index, :edit, :update, :destroy] 
  admin.resources :offerings, :only => [:edit, :update, :destroy, :index] do |offering|
    offering.resources :events, :only => [:index]
  end
  admin.resources :children
end
