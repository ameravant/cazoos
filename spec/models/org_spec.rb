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
  
  it "should fail to create a new record if a required field is missing" do
    required_fields = %w{name description gender min_age max_age}
    required_fields.each do |field|
      @org = Org.create(@valid_attributes.except(field.intern))
      @org.should_not be_valid
      @org.errors.on(field.intern).should == "can't be blank"
    end
  end
end
