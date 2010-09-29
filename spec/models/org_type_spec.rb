require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe OrgType do
  before(:each) do
    @valid_attributes = {
      :title => 'School',
      :description => 'Description of the Schools Type goes here.'
    }
  end
  
  it "should save a valid record" do
    @cat = OrgType.create(@valid_attributes)
    @cat.should_not be_new_record
    @cat.should be_valid
  end
  
  describe 'validations' do
    describe 'on required fields' do
      it "should fail to create a new record if 'title' is missing" do
        missing_required_field_test(:org_type, 'title')
      end
      
      it "should fail to create a new record if 'description' is missing" do
        missing_required_field_test(:org_type, 'description')
      end
    end
  end
  
  describe 'permalink' do
    it "should create a permalink on first save" do
      type = Factory(:org_type)
      type = OrgType.find(type.id)
      type.permalink.should_not be_blank
    end
    
    it "should not change the permalink even if the title and the permalink are edited" do
      type = Factory(:org_type)
      permalink = type.permalink
      type.title = 'Some other title'
      type.permalink = 'SomeBogusPermalink'
      type.save
      type.should_not be_valid
      type = OrgType.find(type.id)
      type.permalink.should == permalink
    end
  end
  
end
  
