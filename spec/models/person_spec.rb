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
  
  it "should disallow several of the same PersonGroup from being glommed on" do
    parent = Factory :parent
    parent.person_groups << PersonGroup.find_by_title('Parent')
    parent = Person.find(parent.id)
    parent.person_group_ids.should == [ PersonGroup.find_by_title('Parent').id ]
  end
  
  it "should not save a person who belongs to no groups" do
    person = Factory.build(:parent, :person_group_ids => [])
    person.should_not be_valid
    person.errors.on(:person_groups).should include("must belong to a group")
  end
  
  it "should respond to person_type method with the name of the PersonGroup" do
    person = Factory :parent
    person.person_type.should == 'Parent'
  end
  
  it "should return an array of its children" do
    parent = Factory :parent
    children = twice{ Factory(:child, :parent_id => parent.id) }
    parent.children.should == [ children[0], children[1] ]
  end
  
  describe "xxxx?" do
    it "should respond to child? method with true if person is a 'Child'" do
      child = Factory.build(:child)
      child.should be_child
    end
    it "should respond to child? method with false if person is not a 'Child'" do
      person = Factory.build(:parent)
      person.should_not be_child
    end
  end

  it "should not be valid if person_type is 'Child' and parent_id is not from a 'Parent'" do
    parent = Factory :child
    owner = Factory :owner
    children = [ Factory.build(:child, :parent_id => owner.id) ]
    children[0].should_not be_valid
    children[0].errors.on(:parent_id).should include('must belong to a parent')
  end

    
end