require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Child do
  before :each do
    @child = Factory(:child)
    @child_detail = Factory(:child_detail, :child => @child)
  end

  it "should conjure up a child detail" do
    @child.detail.should == @child_detail
  end

  describe "validations" do

    it "should save a valid child" do
      @child.should be_valid
      @child.should_not be_new_record
    end
    it "should validate the existence of the parent" do
      owner = Factory(:org_owner)
      @child.parent_id = owner.id
      @child.should_not be_valid
      @child.errors.on(:parent_id).should include("must be registered as a parent in the system")
    end
    it "should validate the associated child detail" do
      @child.detail.update_attributes(:birthday => Time.now + 1.year)
      @child.should_not be_valid
      @child.errors.on(:detail_birthday).should == 'must be before now'
    end
  end

end