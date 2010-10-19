require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Event do
  before(:each) do
    @event = Factory.build :event
    @valid_attributes = {
      :name => 'Name of a Camp',
      :description => 'Description of a Camp',
      :date_and_time => '2010-11-05 12:00:00',
      :end_date_and_time => '2010-11-05 12:00:00',
    	:registration_deadline => '2010-10-18 11:59:59',
    	:registration_limit => '10'
    }
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
      @offering.save
      event = Event.new_offering(@offering)
      event.name.should == @offering.name
      event.description.should == @offering.description
      event.address.should == @offering.org.map_address
      event.offering.should == @offering
    end
    it "should work with a second argument (hash of values), deferring to hash for duplicate values" do
      event = Event.new_offering(@offering, {:name => 'Overwrite name', :blurb => 'Blurbity blurb'})
      event.name.should == 'Overwrite name'
      event.description.should == @offering.description
      event.address.should == @offering.org.map_address
      event.offering.should == @offering
      event.blurb.should == 'Blurbity blurb'
    end
  end
  
  describe "validations" do
    describe 'on required fields' do
      it "should fail to create a new record if 'name' is missing" do
        missing_required_field_test(:event, :name)
      end
      it "should fail to create a new record if 'description' is missing" do
        missing_required_field_test(:event, :description)
      end
      it "should fail to create a new record if 'date_and_time' is missing" do
        missing_required_field_test(:event, :date_and_time)
      end
      it "should fail to create a new record if 'end_date_and_time' is missing" do
        missing_required_field_test(:event, :end_date_and_time)
      end
      it "should fail to create a new record if 'registration_deadline' is missing" do
        missing_required_field_test(:event, :registration_deadline)
      end
      it "should fail to create a new record if 'offering_id' is missing" do
        missing_required_field_test(:event, :offering_id)
      end
    end
    
    it "should allow only integer input for Registration Limit" do
      event = Factory.build :event
      event.registration_limit = '10.5'
      event.save.should == false
      event.should be_new_record
      event.errors.on(:registration_limit).should include('must be a whole number')
    end
  end
end