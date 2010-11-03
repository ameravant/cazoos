namespace :admin do |admin|
  admin.resources :orgs, :as => 'organizations' do |org|
    org.resources :offerings, :only => [:new, :create, :index, :edit, :update, :show]
  end
  admin.resources :org_types, :as => 'organization_types', :except => :show
  admin.resources :activity_categories, :only => [:new, :create, :index, :edit, :update, :destroy] 
  admin.resources :offerings, :only => [:edit, :update, :destroy, :index, :show] do |offering|
    offering.resources :events, :only => [:index, :new, :create]
  end
  admin.resources :parents, :only => [:show, :edit, :update] do |parent|
    parent.resources :children, :only => [:index, :new, :create, :edit, :update]
  end
end
resources :parents, :only => [:new, :create]