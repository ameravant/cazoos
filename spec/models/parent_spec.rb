require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Parent do
  describe "validations" do
    before :each do
      @parent = Factory.build(:parent)
    end
    it "should be valid and save normally when given a valid record" do
      @parent.should be_valid
    end
    
    ###  BEGIN validations that are included in the SiteNinja core
    it "should validate_presence of 'email'" do
      @parent.email = ''
      @parent.should_not be_valid
      @parent.errors.on(:email).should include("can't be blank")
    end
    it "should validate_presence of 'first_name'" do
      @parent.first_name = ''
      @parent.should_not be_valid
      @parent.errors.on(:first_name).should include("can't be blank")
    end
    it "should validate_presence of 'last_name'" do
      @parent.last_name = ''
      @parent.should_not be_valid
      @parent.errors.on(:last_name).should include("can't be blank")
    end
    ###  END validations that are included in the SiteNinja core
    
    it "should validate_format of 'phone'" do
      @parent.phone = '2884'
      @parent.should_not be_valid
      @parent.errors.on(:phone).should include("must be a valid ten-digit phone number")
    end
    it "should validate_presence of 'address1'" do
      @parent.address1 = ''
      @parent.should_not be_valid
      @parent.errors.on(:address1).should include("can't be blank")
    end
    it "should validate_format of 'city'" do
      @parent.city = ''
      @parent.should_not be_valid
      @parent.errors.on(:city).should include("can't be blank")
    end
    it "should validate_format of 'state'" do
      @parent.state = ''
      @parent.should_not be_valid
      @parent.errors.on(:state).should include("can't be blank")
    end
    it "should validate_format of 'zip'" do
      @parent.zip = ''
      @parent.should_not be_valid
      @parent.errors.on(:zip).should include("can't be blank")
    end
  end
  
  it "should respond to 'children'" do
    parent = Factory :parent
    children = twice{ Factory(:child, :parent => parent) }
    parent.children[0].should == children[0]
    parent.children[1].should == children[1]
  end
end