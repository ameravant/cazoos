require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe Admin::EventsController do
  describe "routes description" do
    before :each do
      # @org = Factory.build :org
      # @org.id = 12343
      @activity = Factory.build :activity
      @activity.id = 78697
      @cont = 'admin/events'
    end
    
    it "should have one a List-all route nested in an Activity" do
      assert_recognizes( {:controller => @cont, :action => 'index', :activity_id => "#{@activity.id}"}, 
        admin_activity_events_path(@activity))
      assert_recognizes( {:controller => @cont, :action => 'index', :activity_id => "#{@activity.id}"}, 
        "/admin/activities/#{@activity.id}/events")
    end
    
  end
end
