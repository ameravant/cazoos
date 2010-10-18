require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Event do
  before(:each) do
    @event = Factory.build :event
  end
  
  it "should belong to an offering" do
    @event.should respond_to(:offering_id)
    @event.offering.should be_valid
  end
  
  it "should recognize a valid record as such and save it" do
    @event.should be_valid
    @event.save
    @event.should_not be_new_record
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
    end
    it "should work with a second argument (hash of values), deferring to hash for duplicate values" do
      offering = Factory.build :offering
      event = Event.new_offering(@offering, {:name => 'Overwrite name', :blurb => 'Blurbity blurb'})
      event.name.should == 'Overwrite name'
      event.description.should == @offering.description
      event.address.should == @offering.org.map_address
      event.blurb.should == 'Blurbity blurb'
    end
  end
end