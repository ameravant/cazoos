require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe Admin::OrgsController do
  # integrate_views

  describe "index" do
    it "should route correctly" do
      route_for(:controller => "admin/orgs", :action => "index").should == admin_orgs_path
    end
  end
  
  describe "managing Orgs while logged in as Admin" do
    before :each do
      stub_admin_login
    end
  end
  
  describe "once through the authorization filters" do
    before :each do
      # user = stub(:user) do
      #   stubs(:has_role).returns(true)
      # end
      # controller.stubs(:login_required).returns()
      # controller.stubs(:current_user).returns(user)
      # controller.stubs(:block_intruders).returns()
      # controller.stubs(:load_org_and_reject_if_owner_not_logged_in).returns()
      stub_admin_login
    end
    
    it "should show the Edit page for the Org" do
      set_up_org_stub
      get :edit, :id => @org.id
      response.should render_template('edit')
    end
    
    it "should show the New page for the Org" do
      get :new
      response.should render_template('new')
    end
    
    it "should show the Index page for the Org" do
      get :index
      response.should render_template('index')
    end
    
    describe "when Org is valid" do
      before :each do
        Org.any_instance.stubs(:valid?).returns(true)
      end
      
      it "should redirect to index with a notice when creating an Org" do
        post 'create'
        flash[:notice].should_not be_nil
        response.should redirect_to(admin_orgs_url)
      end
      
      it "should redirect to index with a notice when updating an Org" do
      end
    end
    
  end
  
  it "should redirect to the new_session_url when nobody is logged in" do
    current_user = nil
    controller.stubs(:current_user).returns(current_user)

    get :index
    response.should redirect_to(new_session_url)
    
    post :create
    response.should redirect_to(new_session_url)
    
    get :edit, :id => 1
    response.should redirect_to(new_session_url)
    
    put :update, :id => 1
    response.should redirect_to(new_session_url)
    
    delete :destroy, :id => 1
    response.should redirect_to(new_session_url)
  end

  describe "when an Org Owner is logged in" do
    before :each do
      set_up_org_stub
      stub_org_owner_login
    end
    describe "and trying to mess with another dude's Org, he should get an error and redirect when he tries to" do
      before :each do
        controller.stubs(:org_is_mine?).returns(false)
      end
    
      it "edit it" do
        get :edit, :id => @org.id
        flash[:error].should == 'You do not have access to editing that Organization.'
        response.should redirect_to(root_url)
      end
    
      it "update it" do
        put :update, :id => @org.id
        flash[:error].should == 'You do not have access to editing that Organization.'
        response.should redirect_to(root_url)
      end
    
      it "destroy it" do
        delete :destroy, :id => @org.id
        flash[:error].should == 'You do not have access to editing that Organization.'
        response.should redirect_to(root_url)
      end
    end
  
    describe "and diddling with his own Org, he should get success when he" do
      before :each do
        controller.stubs(:org_is_mine?).returns(true)
      end
    
      it "edits it" do
        get :edit, :id => @org.id
        flash[:error].should be_nil
        response.should render_template('edit')
      end
    
      it "updates it" do
        put :update, :id => @org.id
        flash[:error].should be_nil
        flash[:notice].should include('success')
        response.should redirect_to(admin_orgs_url)
      end
    
      it "destroys it" do
        delete :destroy, :id => @org.id
        flash[:error].should be_nil
        response.should render_template('destroy')
      end
    end
  end
end

def stub_admin_login
  @current_user = stub(:user) do
    stubs(:has_role).with() { |val| val.include?('Admin') }.returns(true)
  end
  controller.stubs(:current_user).returns(@current_user)
end

def stub_org_owner_login  
  signed_in_org_owner_user = stub(:user) do
    stubs(:has_role).with() { |val| val.include?('Organization Owner') }.returns(true)
    stubs(:has_role).with() { |val| !val.include?('Organization Owner') }.returns(false)
  end
  controller.stubs(:current_user).returns(signed_in_org_owner_user)
end

def set_up_org_stub(valid = true)
  @org = Factory.build(:org)
  @org.id = 100
  Org.stubs(:find).returns(@org)
  Org.any_instance.stubs(:valid?).returns(valid)
end