require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

def missing_required_field_test(field_name)
  @org = Org.create(@valid_attributes.except(field_name.intern))
  @org.should_not be_valid
  @org.should be_new_record
  @org.errors.on(field_name.intern).should include("can't be blank")
end

describe Org do
  before(:each) do
    person = Factory.create(:person)
    @valid_attributes = {
      :owner_id => person[:id],
      :name => "Camp Valid",
      :description => "Camp Valid sits nestled in the hills of Tennesee...",
      :gender => "coed",
      :blurb => "Just ask any kid who's been to Camp Valid",
      :min_age => "9",
      :max_age => "12",
      :address => "1234 Any St.",
      :city => "Santa Barbara",
      :state => "CA", 
      :zip => '93101', 
      :contact => "Some Contact",
      :contact_phone => "805-555-1212",
      :contact_email => "contact@campvalid.com"
    }
  end

  it "should create a new instance given valid attributes" do
    Org.create!(@valid_attributes)
  end
  
  describe 'validations' do
    describe 'on required fields' do
      it "should fail to create a new record if 'name' is missing" do
        missing_required_field_test('name')
      end
      
      it "should fail to create a new record if 'description' is missing" do
        missing_required_field_test('description')
      end

      it "should fail to create a new record if 'gender' is missing" do
        missing_required_field_test('gender')
      end

      it "should fail to create a new record if 'min_age' is missing" do
        missing_required_field_test('min_age')
      end

      it "should fail to create a new record if 'max_age' is missing" do
        missing_required_field_test('max_age')
      end

      it "should fail to create a new record if 'address' is missing" do
        missing_required_field_test('address')
      end
      
      it "should fail to create a new record if 'city' is missing" do
        missing_required_field_test('city')
      end      
      
      it "should fail to create a new record if 'state' is missing" do
        missing_required_field_test('state')
      end      
      
      it "should fail to create a new record if 'zip' is missing" do
        missing_required_field_test('zip')
      end      
      
      it "should fail to create a new record if 'contact' is missing" do
        missing_required_field_test('contact')
      end      
      
      it "should fail to create a new record if 'contact_phone' is missing" do
        missing_required_field_test('contact_phone')
      end      
      
      it "should fail to create a new record if 'contact_email' is missing" do
        missing_required_field_test('contact_email')
      end      
    end
  
    it "should fail to save if min_age is non-integer" do
      @org = Org.create(@valid_attributes.merge({ :min_age => '8.5' }))
      @org.should be_new_record
      @org.should_not be_valid
      @org.errors.on(:min_age).should include("must be a whole number")
    end
    
    it "should fail to save if max_age is non-integer" do
      @org = Org.create(@valid_attributes.merge({ :max_age => '8.5' }))
      @org.should be_new_record
      @org.should_not be_valid
      @org.errors.on(:max_age).should include("must be a whole number")
    end
    
    it "should fail to save if max_age is less than min_age" do
      @org = Org.create(@valid_attributes.merge({ :min_age => '13' }))
      @org.should be_new_record
      # @org.should_not be_valid
      @org.errors.on(:min_age).should == "must be less than Max Age"
    end
    
    it "should fail to save if it does not belong to a Person (the Org Owner)" do
      @org = Org.new(@valid_attributes.except(:owner_id))
      @org.save
      @org.should_not be_valid
      @org.errors.on(:owner_id).should include("can't be blank")
    end
    
    it "should fail to save if its OrgOwner is not valid" do
      @org = Org.new(@valid_attributes)
      @owner = Person.find(@org.owner_id)
      @owner.first_name = ''
      @owner.save(false)
      @org.save
      @org.should_not be_valid
      @org.should be_new_record
    end
  end
end
