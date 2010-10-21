require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')


describe Admin::ActivityCategoriesController do
  
  describe "routes description" do
    before :each do
      @record = Factory.build :activity_category
      @record.id = 78697
      @cont = 'admin/activity_categories'
    end
    
    it "should have a New Record route" do
      route_for(:controller => @cont, :action => 'new').should == new_admin_activity_category_path
      new_admin_activity_category_path.should == "/admin/activity_categories/new"
    end
    it "should have a Create Record route" do
      route_for(:controller => @cont, :action => 'create').should == 
        { :path => "/admin/activity_categories", :method => :post }
    end
    it "should have a List-All Record route" do
      route_for(:controller => @cont, :action => 'index').should == "/admin/activity_categories"
    end
    it "should have an Edit Record route" do
      route_for(:controller => @cont, :action => 'edit', :id => "#{@record.id}").should == edit_admin_activity_category_path(@record)
      edit_admin_activity_category_path(@record).should == "/admin/activity_categories/#{@record.id}/edit"
    end
    it "should have an Update Record route" do
      route_for(:controller => @cont, :action => 'update', :id => "#{@record.id}").should == 
        { :path => "/admin/activity_categories/#{@record.id}", :method => :put }
    end
    it "should have a Destroy Record route" do
      route_for(:controller => @cont, :action => 'destroy', :id => "#{@record.id}").should == 
        { :path => "/admin/activity_categories/#{@record.id}", :method => :delete }
    end
  end
  
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
      set_up_activity_category_stub
      get :edit, :id => @activity_category.id
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
      set_up_activity_category_stub
      delete :destroy, :id => @activity_category.id
      response.should render_template('destroy')
    end
    
    describe "when Org is valid" do
      before :each do
        set_up_activity_category_stub
      end
      
      it "should redirect to index with a notice when creating an Org Type" do
        post :create
        flash[:notice].should include('success')
        response.should redirect_to(admin_activity_categories_url)
      end
      
      it "should redirect to index with a notice when updating an Org" do
        put :update, :id => @activity_category.id
        flash[:notice].should include('success')
        response.should redirect_to(admin_activity_categories_url)
      end      
    end
  
    describe "when ActivityCategory is NOT valid" do
      before :each do
        set_up_activity_category_stub(false)
      end

      it "should render the new template and show errors when creating an Org Type" do
        post :create
        flash[:notice].should be_nil
        response.should render_template('new')
      end
      
      it "should redirect to index with a notice when updating an Org Type" do
        put :update, :id => @activity_category.id
        flash[:notice].should be_nil
        response.should render_template('edit')
      end      
    end
    
  end
  
end

def set_up_activity_category_stub(valid = true)
  @activity_category = Factory.build(:activity_category)
  @activity_category.id = 10234
  ActivityCategory.stubs(:find).returns(@activity_category)
  ActivityCategory.any_instance.stubs(:valid?).returns(valid)
end