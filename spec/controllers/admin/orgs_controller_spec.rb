require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe Admin::OrgsController do
  # integrate_views

  describe "index" do
    it "should route correctly" do
      route_for(:controller => "admin/orgs", :action => "index").should == admin_orgs_path
    end
  end
  
  describe "creating a new Org while logged in as Admin" do
    before :each do
      stub_admin_login
    end
    
    it "should redirect to index with a notice when it the new Org is created successfully" do
      Org.any_instance.stubs(:valid?).returns(true)
      post 'create'
      flash[:notice].should_not be_nil
      response.should redirect_to(admin_orgs_url)
    end
  end
  
  it "should redirect to the new_session_url when nobody is logged in" do
    get 'index'
    response.should redirect_to(new_session_url)
    get 'index'
    response.should redirect_to(new_session_url)
    post 'create'
    response.should redirect_to(new_session_url)
    get :edit, :id => 1
    response.should redirect_to(new_session_url)
    put :update, :id => 1
    response.should redirect_to(new_session_url)
    delete :destroy, :id => 1
    response.should redirect_to(new_session_url)
  end
  
  describe "should give an error and redirect back when an Org Owner tries to edit, update or destroy another dude's Org" do
    before :each do
      stub_mismatched_org_owners
    end
    
    it "should not allow edit" do
      get :edit, :id => @org.id
      flash[:error].should == 'You do not have access to editing that Organization.'
      response.should redirect_to(root_url)
    end
    
    it "should not allow update" do
      put :update, :id => @org.id
      flash[:error].should == 'You do not have access to editing that Organization.'
      response.should redirect_to(root_url)
    end
    
    it "should not allow destroy" do
      delete :destroy, :id => @org.id
      flash[:error].should == 'You do not have access to editing that Organization.'
      response.should redirect_to(root_url)
    end
  end
  
  describe "should give a happy notice and go through when an Org Owner works on his own Org" do
    before :each do
      stub_matched_org_owners
    end
    
    it "should allow edit" do
      get :edit, :id => @org.id
      flash[:error].should be_nil
      response.should render_template('edit')
    end
    
    it "should allow update" do
      put :update, :id => @org.id
      flash[:error].should be_nil
      response.should redirect_to(admin_orgs_url)
    end
    
    it "should allow destroy" do
      delete :destroy, :id => @org.id
      flash[:error].should be_nil
      response.should render_template('destroy')
    end
  end
  
    # it "should re-render the new template with errors when the save fails" do
    #   Org.any_instance.stubs(:valid?).returns(false)
    #   post 'create'
    #   flash[:notice].should be_nil
    #   response.should render_template('new')
    # end
end

def stub_admin_login
  # This works b/c having an Admin user belonging to the PersonGroup titled 'Admin' is required for the app to run
  @current_user = PersonGroup.find_by_title('Admin').people.first.user
  controller.stubs(:current_user).returns(@current_user)
end

def stub_matched_org_owners
  stub_signed_in_user(1)
  stub_org_owner(1)
end 

def stub_mismatched_org_owners
  stub_signed_in_user(1)
  stub_org_owner(2)
end

def stub_signed_in_user(user_id)  
  signed_in_org_owner_user = stub(:user) do |u| 
    u.stubs(:id).returns(user_id)
    u.expects(:has_role).with(['Admin','Organization Owner']).returns(true)
    u.expects(:has_role).with(['non-existent-role']).at_most_once.returns(false)      
    # If this causes a fail, yank it; not related to Cazoos app but is there to satisfy mockspectations.
    u.expects(:has_role).with(['Admin', 'Editor', 'Author', 'Moderator']).returns(false)
  end

  controller.stubs(:current_user).returns(signed_in_org_owner_user)
end

def stub_org_owner(user_id)
  unsigned_in_user = stub(:user) do |u|
    u.stubs(:id).returns(user_id)
  end
  person = stub(:person) do |p|
    p.stubs(:user).returns(unsigned_in_user)
  end
  
  @org = Factory :org
  Org.any_instance.stubs(:owner).returns(person)
  Org.any_instance.stubs(:valid?).returns(true)
end