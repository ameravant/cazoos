require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe Admin::EventsController do
  describe "routes description" do
    before :each do
      # @org = Factory.build :org
      # @org.id = 12343
      @offering = Factory.build :offering
      @offering.id = 78697
      @cont = 'admin/events'
    end
    
    it "should have one a List-all route nested in an Activity" do
      assert_recognizes( {:controller => @cont, :action => 'index', :offering_id => "#{@offering.id}"}, 
        admin_offering_events_path(@offering))
      assert_recognizes( {:controller => @cont, :action => 'index', :offering_id => "#{@offering.id}"}, 
        "/admin/offerings/#{@offering.id}/events")
    end
    
  end
end
