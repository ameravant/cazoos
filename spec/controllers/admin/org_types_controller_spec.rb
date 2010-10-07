require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe Admin::OrgTypesController do
  
  describe "- in filtering out unwelcome users -" do
    it "should redirect to the root when someone is logged in other than an admin" do
      set_up_non_super_admin_user
      
      get :index
      verify_root_redirect_with_access_error
      post :create                
      verify_root_redirect_with_access_error
      get :new                    
      verify_root_redirect_with_access_error
      get :edit, :id => 1         
      verify_root_redirect_with_access_error
      put :update, :id => 1       
      verify_root_redirect_with_access_error
      delete :destroy, :id => 1   
      verify_root_redirect_with_access_error
    end
  end
  
  describe "once through the authorization filters" do
    before :each do
      stub_admin_login
    end
    
    it "should show the Edit page for the Org Type" do
      set_up_org_type_stub
      get :edit, :id => @org_type.id
      response.should render_template('edit')
    end
    
    it "should show the New page for the Org Type" do
      get :new
      response.should render_template('new')
    end
    
    it "should show the Index page for the Org" do
      get :index
      response.should render_template('index')
    end
    
    it "should render the destroy template when destroying an Org Type" do
      set_up_org_type_stub
      delete :destroy, :id => @org_type.id
      response.should render_template('destroy')
    end
    
    describe "when Org is valid" do
      before :each do
        set_up_org_type_stub
      end
      
      it "should redirect to index with a notice when creating an Org Type" do
        post :create
        flash[:notice].should include('success')
        response.should redirect_to(admin_org_types_url)
      end
      
      it "should redirect to index with a notice when updating an Org" do
        put :update, :id => @org_type.id
        flash[:notice].should include('success')
        response.should redirect_to(admin_org_types_url)
      end      
    end
  
    describe "when OrgType is NOT valid" do
      before :each do
        set_up_org_type_stub(false)
      end

      it "should render the new template and show errors when creating an Org Type" do
        post :create
        flash[:notice].should be_nil
        response.should render_template('new')
      end
      
      it "should redirect to index with a notice when updating an Org Type" do
        put :update, :id => @org_type.id
        flash[:notice].should be_nil
        response.should render_template('edit')
      end      
    end
    
  end
  
end

def set_up_org_type_stub(valid = true)
  @org_type = Factory.build(:org_type)
  @org_type.id = 10234
  OrgType.stubs(:find).returns(@org_type)
  OrgType.any_instance.stubs(:valid?).returns(valid)
end