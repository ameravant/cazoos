require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe OrgCategory do
  before(:each) do
    @valid_attributes = {
      :title => 'Horseback Riding'
    }
  end
  
  it "should save a valid record" do
    @cat = OrgCategory.create(@valid_attributes)
    @cat.should_not be_new_record
    @cat.should be_valid
  end
  
  describe 'validations' do
    describe 'on required fields' do
      it "should fail to create a new record if 'title' is missing" do
        missing_required_field_test(:org_category, 'title')
      end
    end
  end
  
  describe 'permalink' do
    it "should create a permalink on first save" do
      cat = Factory(:org_category)
      cat = OrgCategory.find(cat.id)
      cat.permalink.should_not be_blank
    end
    
    it "should not change the permalink even if the title and the permalink are edited" do
      cat = Factory(:org_category)
      permalink = cat.permalink
      cat.title = 'Some other title'
      cat.permalink = 'SomeBogusPermalink'
      cat.save
      cat.should_not be_valid
      cat = OrgCategory.find(cat.id)
      cat.permalink.should == permalink
    end
  end
  
end
  
