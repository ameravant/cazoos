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
  
  describe "creating a new record related to a known offering using the new_offering method" do
    before :each do
      @offering = Factory.build :offering
    end
    it "should work with @offering as the argument" do
      event = Event.new_offering(@offering)
      event.name.should == @offering.name
      event.description.should == @offering.description
      event.address.should == @offering.org.map_address
      event.offering.should == @offering
    end
    it "should work with a second argument (hash of values), deferring to hash for duplicate values" do
      offering = Factory.build :offering
      event = Event.new_offering(@offering, {:name => 'Overwrite name', :blurb => 'Blurbity blurb'})
      event.name.should == 'Overwrite name'
      event.description.should == @offering.description
      event.address.should == @offering.org.map_address
      event.blurb.should == 'Blurbity blurb'
      event.offering.should == @offering
    end
  end
end
