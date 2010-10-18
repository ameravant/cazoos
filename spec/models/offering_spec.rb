require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Offering do
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
    act = Offering.create(@valid_attributes)
    act.should_not be_new_record
    act.should be_valid
  end
  
  # it "should have and belong to many Activity Categories" do
  #   pending# Offering.should
  # end
  
  describe 'validations' do
    describe 'on required fields' do
      it "should fail to create a new record if 'name' is missing" do
        missing_required_field_test(:offering, :name)
      end
      
      it "should fail to create a new record if 'description' is missing" do
        missing_required_field_test(:offering, :description)
      end
  
      it "should fail to create a record if 'org_id' is missing" do
        missing_required_field_test(:offering, :org_id)
      end
    end
    
    it "should fail to create a record if the associated Org is not valid" do
      @offering = Offering.new(@valid_attributes)
      @org = Org.find(@offering.org_id)
      @org.name = ''
      @org.save(false)
      @offering.save
      @offering.should_not be_valid
      @offering.should be_new_record
    end
  end
    
end