require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe ActivityCategory do
  before(:each) do
    @valid_attributes = {
      :name => 'Horseback Riding',
      :description => 'Designed to provide children with enjoyment and challenges on all levels...',
      :blurb => 'Blurb about horseback riding'
    }
  end
  
  it "should save a valid record" do
    @cat = ActivityCategory.create(@valid_attributes)
    @cat.should_not be_new_record
    @cat.should be_valid
  end
  
  describe 'validations' do
    describe 'on required fields' do
      it "should fail to create a new record if 'name' is missing" do
        missing_required_field_test(:activity_category, 'name')
      end
      
      it "should fail to create a new record if 'description' is missing" do
        missing_required_field_test(:activity_category, 'description')
      end
      
    end
  end
  
  describe 'permalink' do
    it "should create a permalink on first save" do
      cat = Factory(:activity_category)
      cat = ActivityCategory.find(cat.id)
      cat.permalink.should_not be_blank
    end
  end
  
end
  
