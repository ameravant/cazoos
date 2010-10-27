require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe User do
  it "should respond to admin? with TRUE if the user is in the administrator person_group" do
    user = Factory(:super_user).user
    user.should be_admin
  end
  it "should respond to admin? with FALSE if the user is not in the administrator person_group" do
    user = Factory(:org_owner).user
    user.should_not be_admin
  end
  it "should respond to is_a?(OrgOwner) with TRUE if the associated person is an OrgOwner" do
    user = Factory(:org_owner).user
    user.is_a?(OrgOwner).should == true
  end
  it "should respond to is_a?(OrgOwner) with FALSE if the associated person is not an OrgOwner" do
    user = Factory(:parent).user
    user.is_a?(OrgOwner).should == false
  end
end