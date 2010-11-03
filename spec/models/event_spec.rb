require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Event do
  before(:each) do
    @event = Factory.build :event
  end
  
  it "should belong to an offering" do
    @event.should respond_to(:offering_id)
    @event.offering.should be_valid
  end
  it "should validate the associated offering before saving" do
    @event.offering_id = 0
    @event.should_not be_valid
    @event.save.should == false
    @event.errors.on(:offering_id).should include('must belong to an offering')
  end
  it "should require registration_limit if registration is true" do
    @event.registration = true
    @event.registration_limit = nil
    @event.should_not be_valid
    @event.errors.on(:registration_limit).should include('must be a whole number')
  end
  it "should not require registration_limit if registration is false" do
    @event.registration = false
    @event.registration_limit = nil
    @event.should be_valid
    @event.errors.on(:registration_limit).should be_nil
  end
  
  describe "creating a new record related to a known offering using the build_from_offering method" do
    before :each do
      @offering = Factory.build :offering
    end
    it "should work with @offering as the argument" do
      event = Event.build_from_offering(@offering)
      event.name.should == @offering.name
      event.description.should == @offering.description
      event.address.should == @offering.org.map_address
      event.offering.should == @offering
    end
    it "should work with a second argument (hash of values), deferring to hash for duplicate values" do
      offering = Factory.build :offering
      event = Event.build_from_offering(@offering, {:name => 'Overwrite name', :blurb => 'Blurbity blurb'})
      event.name.should == 'Overwrite name'
      event.description.should == @offering.description
      event.address.should == @offering.org.map_address
      event.blurb.should == 'Blurbity blurb'
      event.offering.should == @offering
    end
  end

  describe "association" do
    it "should have many price options" do
      event = Factory(:random_event)
      price_opt = Factory(:random_price_option, :event_id => event.id)
      price_opt2 = Factory(:random_price_option, :event_id => event.id)
      price_opt3 = Factory(:random_price_option, :event_id => event.id + 1)
      event.price_options.should == [price_opt, price_opt2]
      event.price_options.should_not include price_opt3      
    end
  end
  describe "scopes" do
    before(:each) do
      @events = threeTimes{Factory(:random_event)}
    end
  end

  # Added by John Lawrence on 2010-10-20.  Never run.  Delete or modify if necessary.
  it "should recognize a valid record as such and save it" do
    @events[0].should be_valid
    @events[0].save
    @events[0].should_not be_new_record
  end
end
