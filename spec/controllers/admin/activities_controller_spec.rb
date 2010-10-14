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
    
    # Edit and Update don't really need this, since the :id unambigously identifies the Activity, 
    #    but it helps to track what scope the user came from when redirecting them back after a successful update
    it "should have an Edit Record route nested in the Organization" do
      route_for(:controller => @cont, :action => 'edit', :org_id => "#{@org.id}", :id => "#{@activity.id}").should == 
        edit_admin_org_activity_path(@org, @activity)
      edit_admin_org_activity_path(@org, @activity).should == "/admin/organizations/#{@org.id}/activities/#{@activity.id}/edit"
    end
    it "should have an Edit Record route nested in the Organization" do
      route_for(:controller => @cont, :action => 'update', :org_id => "#{@org.id}", :id => "#{@activity.id}").should == 
        { :path => "/admin/organizations/#{@org.id}/activities/#{@activity.id}", :method => :put }
    end
    
    # Un-nested routes
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
  
  describe "once through the authorization filters" do
    before :each do
      stub_admin_login
    end
    
    it "should show the Edit page for the Activity" do
      set_up_record_stub :activity
      get :edit, :id => @activity.id
      response.should render_template('edit')
    end
    
    it "should show the New page for the Activity" do
      set_up_record_stub :org
      get :new, :org_id => @org.id
      response.should render_template('new')
    end
    
    it "should show the Index page for the Activity" do
      get :index
      response.should render_template('index')
    end
    
    it "should render the destroy template when destroying an Activity" do
      set_up_record_stub :activity
      delete :destroy, :id => @activity.id
      response.should render_template('destroy')
    end
    
    it "should destroy the record when called to do so" do
      set_up_record_stub :activity
      @activity.expects(:destroy)
      delete :destroy, :id => @activity.id
    end
    
    describe "when Activity is valid" do
      before :each do
        set_up_record_stub :activity
      end

      it "should redirect to index with a notice when creating an Activity" do
        set_up_record_stub :org
        post :create, :org_id => @org.id
        flash[:notice].should include('success')
        response.should redirect_to(admin_org_activities_url(@org))
      end
      
      it "should redirect to index with a notice when updating an Activity" do
        put :update, :id => @activity.id
        flash[:notice].should include('success')
        response.should redirect_to(admin_activities_url)
      end      
    end

    describe "when Activity is NOT valid" do
      before :each do
        set_up_record_stub :activity, false
      end
      
      it "should render the new template and show errors when creating an Activity" do
        set_up_record_stub :org
        post :create, :org_id => @org.id
        flash[:notice].should be_nil
        response.should render_template('new')
      end
      
      it "should redirect to index with a notice when updating an Activity" do
        put :update, :id => @activity.id
        flash[:notice].should be_nil
        response.should render_template('edit')
      end      
    end
    
  end

  describe "when an Org Owner is logged in" do
    before :each do
      set_up_record_stub :activity
      stub_activity_owner_login
    end

    it "should not allow visit to the index page without an org_id" do
      get :index
      flash[:error].should include 'do not have access'
      response.should redirect_to(root_url)
    end

    describe "and trying to mess with another dude's Activity, he should get an error and redirect when he tries to" do
      before :each do
        controller.stubs(:activity_is_mine?).returns(false)
      end
      
      it "see the Org's Activities" do
        set_up_record_stub :org
        controller.stubs(:org_is_mine?).returns(false)
        get :index, :org_id => @org.id
        flash[:error].should include "do not have access to that."
        response.should redirect_to(root_url)
      end
      
      it "edit it" do
        get :edit, :id => @activity.id
        flash[:error].should == 'You do not have access to editing that Activity.'
        response.should redirect_to(root_url)
      end
    
      it "update it" do
        put :update, :id => @activity.id
        flash[:error].should == 'You do not have access to editing that Activity.'
        response.should redirect_to(root_url)
      end
    
      it "destroy it" do
        delete :destroy, :id => @activity.id
        flash[:error].should == 'You do not have access to editing that Activity.'
        response.should redirect_to(root_url)
      end
    end
  
    describe "and diddling with his own Activity, he should get success when he" do
      before :each do
        controller.stubs(:activity_is_mine?).returns(true)
        set_up_record_stub :org
      end
    
      it "edits it" do
        get :edit, :id => @activity.id, :org_id => @org.id
        flash[:error].should be_nil
        response.should render_template('edit')
      end
    
      it "updates it" do
        put :update, :id => @activity.id, :org_id => @org.id
        flash[:error].should be_nil
        flash[:notice].should include('success')
        response.should redirect_to(admin_org_activities_url(@org))
      end
    
      it "destroys it" do
        delete :destroy, :id => @activity.id
        flash[:error].should be_nil
        response.should render_template('destroy')
      end
    end
  end
  
  describe "when an Admin is logged in" do
    before :each do
      stub_admin_login      
      set_up_record_stub :activity
    end
    
    it "should assign only the activities belonging to the Org (:org_id) to the variable @activities" do
      set_up_record_stub :org
      Activity.expects(:all).with(:conditions => ['org_id=?', "#{@org.id}"]).returns([@activity])
      get :index, :org_id => @org.id
      assigns[:activities].should == [@activity]
    end
    
    it "should assign all activities to the variable @activities" do
      Activity.expects(:all).returns([@activity])
      get :index
      assigns[:activities].should == [@activity]
    end 
    
  end
end

def stub_activity_owner_login  
  signed_in_org_owner_user = stub(:user) do
    stubs(:has_role).with() { |val| val.include?('Organization Owner') }.returns(true)
    stubs(:has_role).with() { |val| !val.include?('Organization Owner') }.returns(false)
  end
  controller.stubs(:current_user).returns(signed_in_org_owner_user)
end