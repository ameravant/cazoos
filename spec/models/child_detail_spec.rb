require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe ChildDetail do
  describe "validations" do
    before :each do
      @detail = Factory.build(:child_detail)
    end
    
    it "should recognize a valid record" do
      @detail.should be_valid
    end
    
    it "should validate the birthdate is before now" do
      @detail.birthday = '2011-01-01'
      @detail.should_not be_valid
      @detail.errors.on(:birthday).should == 'must be before now'
    end
    
    it "should validate_presence of birthday" do
      @detail.birthday = ''
      @detail.should_not be_valid
      @detail.errors.on(:birthday).should == "can't be blank"
    end
    
    it "should validate_presence of gender" do
      @detail.gender = ''
      @detail.should_not be_valid
      @detail.errors.on(:gender).should == "can't be blank"      
    end
  end
end