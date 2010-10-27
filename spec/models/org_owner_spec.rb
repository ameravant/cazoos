require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe OrgOwner do
  it "should respond to 'org'" do
    org_owner = Factory :org_owner
    org_owner.should respond_to(:org)
  end
end