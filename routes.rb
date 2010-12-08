namespace :admin do |admin|
  admin.resources :orgs, :as => 'organizations' do |org|
    org.resources :events, :as => 'programs'
  end
  admin.resources :org_types, :as => 'organization-types', :except => :show
  admin.resources :activity_categories, :only => [:new, :create, :index, :edit, :update, :destroy] 
  admin.resources :parents, :only => [:show, :edit, :update] do |parent|
    parent.resources :children, :only => [:index, :new, :create, :edit, :update]
  end
end
resources :parents, :only => [:new, :create]
resources :orgs, :as => 'organizations' do |org|
  org.resources :events, :has_many => :images, :collection => { :past => :get }
end
resources :events, :as => 'programs' do |event|
  event.resources :event_registration_groups,
    :belongs_to => :people,
    :has_many => :event_registrations,
    :member => { :pay => :get, :complete => :get }
end
# From the events module

namespace :admin do |admin|
  admin.resources :org_owners
  admin.resources :events, :has_many => [ :event_price_options, :features, :assets ] do |event|
  admin.resources :event_categories, :has_many => { :features, :menus } do |event_category|
    event_category.resources :menus
    event_category.resources :images, :member => { :reorder => :put }, :collection => { :reorder => :put }
  end
    event.resources :images, :member => { :reorder => :put }, :collection => { :reorder => :put }
    event.resources :event_registration_groups,
      :has_many => :contacts,
      :member => {:paid => :get, :unpaid => :get }, 
      :collection => {:csv => :get}
  end
end
resources :event_categories

addpeople '/addpeople', :controller => "registration_people", :action => "index"
