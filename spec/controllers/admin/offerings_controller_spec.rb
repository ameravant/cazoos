require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe Admin::OfferingsController do
  describe "routes description" do
    before :each do
      @org = Factory.build :org
      @org.id = 12343
      @offering = Factory.build :offering
      @offering.id = 78697
      @cont = 'admin/offerings'
    end
    
    it "should have one a New Record route nested in the Organization" do
      route_for(:controller => @cont, :action => 'new', :org_id => "#{@org.id}").should == new_admin_org_offering_path(@org)
      new_admin_org_offering_path(@org).should == "/admin/organizations/#{@org.id}/offerings/new"
    end
    it "should have a Create Record route nested in the Organization" do
      route_for(:controller => @cont, :action => 'create', :org_id => "#{@org.id}").should == 
        { :path => "/admin/organizations/#{@org.id}/offerings", :method => :post }
    end
    it "should have a 'List-All' route nested in the Organization" do
      route_for(:controller => @cont, :action => 'index', :org_id => "#{@org.id}").should == admin_org_offerings_path(@org)
      admin_org_offerings_path(@org).should == "/admin/organizations/#{@org.id}/offerings"
    end
    
    # Edit, Update and Show don't really need this, since the :id unambigously identifies the Offering, 
    #    but it helps to track what scope the user came from when redirecting them back after a successful update
    it "should have an Edit Record route nested in the Organization" do
      route_for(:controller => @cont, :action => 'edit', :org_id => "#{@org.id}", :id => "#{@offering.id}").should == 
        edit_admin_org_offering_path(@org, @offering)
      edit_admin_org_offering_path(@org, @offering).should == "/admin/organizations/#{@org.id}/offerings/#{@offering.id}/edit"
    end
    it "should have an Update Record route nested in the Organization" do
      route_for(:controller => @cont, :action => 'update', :org_id => "#{@org.id}", :id => "#{@offering.id}").should == 
        { :path => "/admin/organizations/#{@org.id}/offerings/#{@offering.id}", :method => :put }
    end
    it "should have a Show Record route nested in the Organization" do
      assert_recognizes( {:controller => @cont, :action => 'show', :org_id => "#{@org.id}", :id => "#{@offering.id}"},
        { :path => admin_org_offering_path(@org, @offering), :method => 'get' } )
      admin_org_offering_path(@org, @offering).should == "/admin/organizations/#{@org.id}/offerings/#{@offering.id}"
    end
    
    # Un-nested routes
    it "should have an Edit Record route" do
      route_for(:controller => @cont, :action => 'edit', :id => "#{@offering.id}").should == edit_admin_offering_path(@offering)
      edit_admin_offering_path(@offering).should == "/admin/offerings/#{@offering.id}/edit"
    end
    it "should have an Update Record route" do
      route_for(:controller => @cont, :action => 'update', :id => "#{@offering.id}").should == 
        { :path => "/admin/offerings/#{@offering.id}", :method => :put }
    end
    it "should have a Show Record route" do
      assert_recognizes( { :controller => @cont, :action => 'show', :id => "#{@offering.id}" },
        admin_offering_path(@offering) )
      admin_offering_path(@offering).should == "/admin/offerings/#{@offering.id}"
    end
    it "should have a Destroy Record route" do
      route_for(:controller => @cont, :action => 'destroy', :id => "#{@offering.id}").should == 
        { :path => "/admin/offerings/#{@offering.id}", :method => :delete }
    end
    it "should have a 'List-All' route" do
      route_for(:controller => @cont, :action => 'index').should == admin_offerings_path
      admin_offerings_path.should == "/admin/offerings"
    end
  end
  
  describe "once through the authorization filters" do
    before :each do
      stub_admin_login
    end
    
    it "should show the Edit page for the Offering" do
      set_up_record_stub :offering
      get :edit, :id => @offering.id
      response.should render_template('edit')
    end
    
    it "should show the New page for the Offering" do
      set_up_record_stub :org
      get :new, :org_id => @org.id
      response.should render_template('new')
    end
    
    it "should show the Index page for the Offering" do
      get :index
      response.should render_template('index')
    end
    
    it "should render the destroy template when destroying an Offering" do
      set_up_record_stub :offering
      delete :destroy, :id => @offering.id
      response.should render_template('destroy')
    end
    
    it "should destroy the record when called to do so" do
      set_up_record_stub :offering
      @offering.expects(:destroy)
      delete :destroy, :id => @offering.id
    end
    
    describe "when Offering is valid" do
      before :each do
        set_up_record_stub :offering
      end

      it "should redirect to index with a notice when creating an Offering" do
        set_up_record_stub :org
        post :create, :org_id => @org.id
        flash[:notice].should include('success')
        response.should redirect_to(admin_org_offerings_url(@org))
      end
      
      it "should redirect to index with a notice when updating an Offering" do
        put :update, :id => @offering.id
        flash[:notice].should include('success')
        response.should redirect_to(admin_offerings_url)
      end      
    end

    describe "when Offering is NOT valid" do
      before :each do
        set_up_record_stub :offering, false
      end
      
      it "should render the new template and show errors when creating an Offering" do
        set_up_record_stub :org
        post :create, :org_id => @org.id
        flash[:notice].should be_nil
        response.should render_template('new')
      end
      
      it "should redirect to index with a notice when updating an Offering" do
        put :update, :id => @offering.id
        flash[:notice].should be_nil
        response.should render_template('edit')
      end      
    end
    
  end

  describe "when an Org Owner is logged in" do
    before :each do
      set_up_record_stub :offering
      stub_offering_owner_login
    end

    it "should not allow visit to the index page without an org_id" do
      get :index
      flash[:error].should include 'do not have access'
      response.should redirect_to(root_url)
    end

    describe "and trying to mess with another dude's Offering, he should get an error and redirect when he tries to" do
      before :each do
        controller.stubs(:offering_is_mine?).returns(false)
      end
      
      it "see the Org's Offerings" do
        set_up_record_stub :org
        controller.stubs(:org_is_mine?).returns(false)
        get :index, :org_id => @org.id
        flash[:error].should include "do not have access to that."
        response.should redirect_to(root_url)
      end
      
      it "edit it" do
        get :edit, :id => @offering.id
        flash[:error].should == 'You do not have access to editing that Offering.'
        response.should redirect_to(root_url)
      end
    
      it "update it" do
        put :update, :id => @offering.id
        flash[:error].should == 'You do not have access to editing that Offering.'
        response.should redirect_to(root_url)
      end
    
      it "destroy it" do
        delete :destroy, :id => @offering.id
        flash[:error].should == 'You do not have access to editing that Offering.'
        response.should redirect_to(root_url)
      end
    end
  
    describe "and diddling with his own Offering, he should get success when he" do
      before :each do
        controller.stubs(:offering_is_mine?).returns(true)
        set_up_record_stub :org
      end
    
      it "edits it" do
        get :edit, :id => @offering.id, :org_id => @org.id
        flash[:error].should be_nil
        response.should render_template('edit')
      end
    
      it "updates it" do
        put :update, :id => @offering.id, :org_id => @org.id
        flash[:error].should be_nil
        flash[:notice].should include('success')
        response.should redirect_to(admin_org_offerings_url(@org))
      end
    
      it "destroys it" do
        delete :destroy, :id => @offering.id
        flash[:error].should be_nil
        response.should render_template('destroy')
      end
    end
  end
  
  describe "when an Admin is logged in" do
    before :each do
      stub_admin_login      
      set_up_record_stub :offering
    end
    
    it "should assign only the offerings belonging to the Org (:org_id) to the variable @offerings" do
      set_up_record_stub :org
      Offering.expects(:all).with(:conditions => ['org_id=?', "#{@org.id}"]).returns([@offering])
      get :index, :org_id => @org.id
      assigns[:offerings].should == [@offering]
    end
    
    it "should assign all offerings to the variable @offerings" do
      Offering.expects(:all).returns([@offering])
      get :index
      assigns[:offerings].should == [@offering]
    end 
    
  end
end

def stub_offering_owner_login  
  signed_in_org_owner_user = stub(:user) do
    stubs(:has_role).with() { |val| val.include?('Organization Owner') }.returns(true)
    stubs(:has_role).with() { |val| !val.include?('Organization Owner') }.returns(false)
  end
  controller.stubs(:current_user).returns(signed_in_org_owner_user)
end