require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Org do
  before(:each) do
    @valid_attributes = {
      :name => "Camp Valid",
      :description => "Camp Valid sits nestled in the hills of Tennesee...",
      :gender => "coed",
      :blurb => "Just ask any kid who's been to Camp Valid",
      :min_age => "9",
      :max_age => "12"
    }
  end

  it "should create a new instance given valid attributes" do
    Org.create!(@valid_attributes)
  end
  
  describe 'validations' do
    describe 'on required fields' do
      it "should fail to create a new record if 'name' is missing" do
        @org = Org.create(@valid_attributes.except(:name))
        @org.should_not be_valid
        @org.should be_new_record
        @org.errors.on(:name).should == "can't be blank"
      end
      
      it "should fail to create a new record if 'description' is missing" do
        @org = Org.create(@valid_attributes.except(:description))
        @org.should_not be_valid
        @org.should be_new_record
        @org.errors.on(:description).should == "can't be blank"
      end

      it "should fail to create a new record if 'gender' is missing" do
        @org = Org.create(@valid_attributes.except(:gender))
        @org.should_not be_valid
        @org.should be_new_record
        @org.errors.on(:gender).should == "can't be blank"
      end

      it "should fail to create a new record if 'min_age' is missing" do
        @org = Org.create(@valid_attributes.except(:min_age))
        @org.should_not be_valid
        @org.should be_new_record
        @org.errors.on(:min_age).should include("can't be blank")
      end

      it "should fail to create a new record if 'max_age' is missing" do
        @org = Org.create(@valid_attributes.except(:max_age))
        @org.should_not be_valid
        @org.should be_new_record
        @org.errors.on(:max_age).should include("can't be blank")
      end
      
    end
  
    it "should fail to save if min_age is non-integer" do
      @org = Org.create(@valid_attributes.merge({ :min_age => '8.5' }))
      @org.should be_new_record
      @org.should_not be_valid
      @org.errors.on(:min_age).should == "must be a whole number"
    end
    
    it "should fail to save if max_age is less than min_age" do
      @org = Org.create(@valid_attributes.merge({ :min_age => '13' }))
      @org.should be_new_record
      # @org.should_not be_valid
      @org.errors.on(:min_age).should == "must be less than Max Age"
    end
  end
end
