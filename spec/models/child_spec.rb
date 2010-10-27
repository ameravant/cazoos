require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Child do
  describe "validations" do
    before :each do
      @child = Factory.build(:child)
    end
    
    it "should save a valid child" do
      @child.should be_valid
      @child.save
      @child.should_not be_new_record
    end
    it "should validate the existence of the parent" do
      owner = Factory(:org_owner)
      @child.parent_id = owner.id
      @child.should_not be_valid
      @child.errors.on(:parent_id).should include("must be registered as a parent in the system")
    end
  end
end