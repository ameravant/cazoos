require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe Admin::EventsController do
  describe "routes description" do
    before :each do
      # @org = Factory.build :org
      # @org.id = 12343
      set_up_record_stub :offering
      @cont = 'admin/events'
    end
    
    it "should have one a List-all route nested in an Offering" do
      assert_recognizes( {:controller => @cont, :action => 'index', :offering_id => "#{@offering.id}"}, 
        admin_offering_events_path(@offering))
      assert_recognizes( {:controller => @cont, :action => 'index', :offering_id => "#{@offering.id}"}, 
        "/admin/offerings/#{@offering.id}/events")
    end
    it "should have one a New Event route nested in an Offering" do
      assert_recognizes( {:controller => @cont, :action => 'new', :offering_id => "#{@offering.id}"}, 
        new_admin_offering_event_path(@offering))
      assert_recognizes( {:controller => @cont, :action => 'new', :offering_id => "#{@offering.id}"}, 
        "/admin/offerings/#{@offering.id}/events/new")
    end
    it "should have a Create Event route nested in an Offering" do
      assert_recognizes( {:controller => @cont, :action => 'create', :offering_id => "#{@offering.id}"},
        {:path => admin_offering_events_path(@offering), :method => 'post'})
    end
    
  end
  
  describe "index action" do
    before :each do
      stub_admin_login
      set_up_record_stub :offering
    end
    
    it "should assign @offering to the view" do
      Offering.expects(:find).with(@offering.id.to_s).returns(@offering)
      get :index, :offering_id => @offering.id
      assigns[:offering].should == @offering
    end
  end
  
  describe "new action" do
    before :each do
      stub_admin_login
      set_up_record_stub :offering
    end
    
    it "should assign @offering to the view" do
      Offering.expects(:find).with(@offering.id.to_s).returns(@offering)
      get :new, :offering_id => @offering.id
      assigns[:offering].should == @offering
    end
    
    it "should assign @event to the view with the name & description of the offering and the address of the Org" do
      new_event = Event.build_from_offering(@offering)
      Event.expects(:build_from_offering).returns(new_event)
      get :new, :offering_id => @offering.id
      assigns[:event].should == new_event
    end
  end
  
  describe "create action" do
    before :each do
      stub_admin_login
      set_up_record_stub :offering
      set_up_record_stub :event  # sets up valid stub @event
    end
    
    it "should assign @offering to the view" do
      Offering.expects(:find).with(@offering.id.to_s).returns(@offering)
      post :create, :offering_id => @offering.id, :event => {}
      assigns[:offering].should == @offering
    end

    it "should build the event from the offering and the parameters" do
      Event.expects(:build_from_offering).with() do |offering, event_params| 
        offering == @offering
        event_params.is_a?(Hash)
      end.returns(@event)
      post :create, :offering_id => @offering.id, :event => {}
    end
    
    it "should save a valid record and redirect to the Offering page" do
      @event.expects(:save).returns(true)
      Event.expects(:build_from_offering).returns(@event).returns(@event)
      post :create, :offering_id => @offering.id, :event => {}
      flash[:notice].should == 'Event created, would you like to add price options'
      response.should redirect_to(new_admin_event_event_price_option_path(@event))
    end

    it "should not save an invalid record, and it should render 'new' template" do
      @event.expects(:save).returns(false)
      Event.expects(:build_from_offering).returns(@event).returns(@event)
      post :create, :offering_id => @offering.id, :event => {}
      flash[:notice].should be_nil
      response.should render_template('new')
    end

  end
end
