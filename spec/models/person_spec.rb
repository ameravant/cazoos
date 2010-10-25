require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Person do
  # This is admittedly abnormal for a has_and_belongs_to_many relationship.  In Cazoos app, however, we
  #     don't ever want a person in two of the four PersonGroups(Admin, Org Owner, Parent, Child)
  it "should not allow a person in the system to belong to more than one group" do
    parent = Factory :parent
    parent.person_groups << PersonGroup.find_by_title('Child')
    parent = Person.find(parent.id)
    parent.person_group_ids.should == [ PersonGroup.find_by_title('Parent').id ]
  end
end