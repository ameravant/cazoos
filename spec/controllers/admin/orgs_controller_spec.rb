require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe Admin::OrgsController do
  # integrate_views

  describe "routes" do
    before :each do
      @org = Factory.build :org
      @org.id = 29899
      @cont = 'admin/orgs'
    end
    
    it "should include a Show route" do
      assert_recognizes({:controller => @cont, :action => 'show', :id => @org.id.to_s}, admin_org_path(@org))
      assert_recognizes({:controller => @cont, :action => 'show', :id => @org.id.to_s}, "/admin/organizations/#{@org.id}")
    end
  end
  
  describe "once through the authorization filters" do
    before :each do
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
    
    it "should render the destroy template when destroying an Org" do
      set_up_org_stub
      delete :destroy, :id => @org.id
      response.should render_template('destroy')
    end
    
    describe "when Org is valid" do
      before :each do
        set_up_org_stub
      end

      it "should redirect to index with a notice when creating an Org" do
        post :create
        flash[:notice].should include('success')
        response.should redirect_to(admin_orgs_url)
      end
      
      it "should redirect to index with a notice when updating an Org" do
        put :update, :id => @org.id
        flash[:notice].should include('success')
        response.should redirect_to(admin_orgs_url)
      end      
    end

    describe "when Org is NOT valid" do
      before :each do
        set_up_org_stub(false)
      end
      
      it "should render the new template and show errors when creating an Org" do
        post :create
        flash[:notice].should be_nil
        response.should render_template('new')
      end
      
      it "should redirect to index with a notice when updating an Org" do
        put :update, :id => @org.id
        flash[:notice].should be_nil
        response.should render_template('edit')
      end      
    end
    
  end

  describe "when an Org Owner is logged in" do
    before :each do
      set_up_org_stub
      stub_org_owner_login
    end
    
    it "should reject him if he tries to see the list of all Organizations" do
      get :index
      response.should redirect_to(root_url)
      flash[:error].should include('do not have access')
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