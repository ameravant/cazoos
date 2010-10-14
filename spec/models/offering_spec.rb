require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Activity do
  before(:each) do
    cat = Factory :activity_category
    org = Factory :org
    @valid_attributes = {
      :org_id => org.id,
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
    pending# Activity.should
  end
  
  describe 'validations' do
    describe 'on required fields' do
      it "should fail to create a new record if 'name' is missing" do
        missing_required_field_test(:activity, :name)
      end
      
      it "should fail to create a new record if 'description' is missing" do
        missing_required_field_test(:activity, :description)
      end
  
      it "should fail to create a record if 'org_id' is missing" do
        missing_required_field_test(:activity, :org_id)
      end
    end
    
    it "should fail to create a record if the associated Org is not valid" do
      @activity = Activity.new(@valid_attributes)
      @org = Org.find(@activity.org_id)
      @org.name = ''
      @org.save(false)
      @activity.save
      @activity.should_not be_valid
      @activity.should be_new_record
    end
  end
    
end