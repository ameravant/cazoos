require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe Admin::ActivitiesController do
  describe "routes description" do
    before :each do
      @org = Factory.build :org
      @org.id = 12343
      @activity = Factory.build :activity
      @activity.id = 78697
      @cont = 'admin/activities'
    end
    
    it "should have one a New Record route nested in the Organization" do
      route_for(:controller => @cont, :action => 'new', :org_id => "#{@org.id}").should == new_admin_org_activity_path(@org)
      new_admin_org_activity_path(@org).should == "/admin/organizations/#{@org.id}/activities/new"
    end
    it "should have a Create Record route nested in the Organization" do
      route_for(:controller => @cont, :action => 'create', :org_id => "#{@org.id}").should == 
        { :path => "/admin/organizations/#{@org.id}/activities", :method => :post }
    end
    it "should have a 'List-All' route nested in the Organization" do
      route_for(:controller => @cont, :action => 'index', :org_id => "#{@org.id}").should == admin_org_activities_path(@org)
      admin_org_activities_path(@org).should == "/admin/organizations/#{@org.id}/activities"
    end
    
    it "should have an Edit Record route" do
      route_for(:controller => @cont, :action => 'edit', :id => "#{@activity.id}").should == edit_admin_activity_path(@activity)
      edit_admin_activity_path(@activity).should == "/admin/activities/#{@activity.id}/edit"
    end
    it "should have an Update Record route" do
      route_for(:controller => @cont, :action => 'update', :id => "#{@activity.id}").should == 
        { :path => "/admin/activities/#{@activity.id}", :method => :put }
    end
    it "should have a Destroy Record route" do
      route_for(:controller => @cont, :action => 'destroy', :id => "#{@activity.id}").should == 
        { :path => "/admin/activities/#{@activity.id}", :method => :delete }
    end
    it "should have a 'List-All' route" do
      route_for(:controller => @cont, :action => 'index').should == admin_activities_path
      admin_activities_path.should == "/admin/activities"
    end
  end
#   describe "once through the authorization filters" do
#     before :each do
#       stub_admin_login
#     end
#     
#     it "should show the Edit page for the Activity" do
#       set_up_activity_stub
#       get :edit, :id => @activity.id
#       response.should render_template('edit')
#     end
#     
#     it "should show the New page for the Activity" do
#       get :new
#       response.should render_template('new')
#     end
#     
#     it "should show the Index page for the Activity" do
#       get :index
#       response.should render_template('index')
#     end
#     
#     it "should render the destroy template when destroying an Activity" do
#       set_up_activity_stub
#       delete :destroy, :id => @activity.id
#       response.should render_template('destroy')
#     end
#     
#     describe "when Activity is valid" do
#       before :each do
#         set_up_activity_stub
#       end
# 
#       it "should redirect to index with a notice when creating an Activity" do
#         post :create
#         flash[:notice].should include('success')
#         response.should redirect_to(admin_activities_url)
#       end
#       
#       it "should redirect to index with a notice when updating an Activity" do
#         put :update, :id => @activity.id
#         flash[:notice].should include('success')
#         response.should redirect_to(admin_activities_url)
#       end      
#     end
# 
#     describe "when Activity is NOT valid" do
#       before :each do
#         set_up_activity_stub(false)
#       end
#       
#       it "should render the new template and show errors when creating an Activity" do
#         post :create
#         flash[:notice].should be_nil
#         response.should render_template('new')
#       end
#       
#       it "should redirect to index with a notice when updating an Activity" do
#         put :update, :id => @activity.id
#         flash[:notice].should be_nil
#         response.should render_template('edit')
#       end      
#     end
#     
#   end
# 
#   describe "when an Org Owner is logged in" do
#     before :each do
#       set_up_activity_stub
#       stub_activity_owner_login
#     end
#     describe "and trying to mess with another dude's Activity, he should get an error and redirect when he tries to" do
#       before :each do
#         controller.stubs(:activity_is_mine?).returns(false)
#       end
#     
#       it "edit it" do
#         get :edit, :id => @activity.id
#         flash[:error].should == 'You do not have access to editing that Activity.'
#         response.should redirect_to(root_url)
#       end
#     
#       it "update it" do
#         put :update, :id => @activity.id
#         flash[:error].should == 'You do not have access to editing that Activity.'
#         response.should redirect_to(root_url)
#       end
#     
#       it "destroy it" do
#         delete :destroy, :id => @activity.id
#         flash[:error].should == 'You do not have access to editing that Activity.'
#         response.should redirect_to(root_url)
#       end
#     end
#   
#     describe "and diddling with his own Activity, he should get success when he" do
#       before :each do
#         controller.stubs(:activity_is_mine?).returns(true)
#       end
#     
#       it "edits it" do
#         get :edit, :id => @activity.id
#         flash[:error].should be_nil
#         response.should render_template('edit')
#       end
#     
#       it "updates it" do
#         put :update, :id => @activity.id
#         flash[:error].should be_nil
#         flash[:notice].should include('success')
#         response.should redirect_to(admin_activities_url)
#       end
#     
#       it "destroys it" do
#         delete :destroy, :id => @activity.id
#         flash[:error].should be_nil
#         response.should render_template('destroy')
#       end
#     end
#   end
end

def stub_activity_owner_login  
  signed_in_org_owner_user = stub(:user) do
    stubs(:has_role).with() { |val| val.include?('Organization Owner') }.returns(true)
    stubs(:has_role).with() { |val| !val.include?('Organization Owner') }.returns(false)
  end
  controller.stubs(:current_user).returns(signed_in_org_owner_user)
end

def set_up_activity_stub(valid = true)
  @activity = Factory.build(:activity)
  @activity.id = 10929
  Activity.stubs(:find).returns(@activity)
  Activity.any_instance.stubs(:valid?).returns(valid)
end