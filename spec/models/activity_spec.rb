require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Activity do
  before(:each) do
    cat = Factory :activity_category
    @valid_attributes = {
      :activity_category_ids => [ cat.id ],
      :name => 'Horseback Riding',
      :description => 'Designed to provide children with enjoyment and challenges on all levels...'
    }
  end
  
  it "should save a valid record" do
    act = Activity.create(@valid_attributes)
    act.should_not be_new_record
    act.should be_valid
  end
  
  it "should have and belong to many Activity Categories" do
    Activity.should
  end
  
  describe 'validations' do
    describe 'on required fields' do
      it "should fail to create a new record if 'name' is missing" do
        missing_required_field_test(:activity, :name)
      end
      
      it "should fail to create a new record if 'description' is missing" do
        missing_required_field_test(:activity, :description)
      end
      
    end
  end
    
end