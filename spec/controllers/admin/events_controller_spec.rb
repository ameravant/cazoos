require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe Admin::EventsController do
  describe "routes description" do
    before :each do
      @org = Factory.build :org
      @org.id = 12343
      @activity = Factory.build :activity
      @activity.id = 78697
      @cont = 'admin/events'
    end
    
    it "should have one a List-all route nested in the Organization" do
      route_for(:controller => @cont, :action => 'index', :org_id => @org.id.to_s).should == admin_org_events_path(@org)
      admin_org_events_path(@org).should == "/admin/organizations/#{@org.id}/events"
    end
    it "should have one a List-all route nested in an Activity" do
      route_for(:controller => @cont, :action => 'index', :activity_id => "#{@activity.id}").should == 
        admin_activity_events_path(@activity)
      admin_activity_events_path(@activity).should == "/admin/activities/#{@activity.id}/events"
    end
    it "should have one a List-all route nested in an Activity" do
      route_for(:controller => 'admin/genitals', :action => 'index', :activity_id => "#{@activity.id}").should == 
        admin_activity_genitals_path(@activity)
      admin_activity_genitals_path(@activity).should == "/admin/activities/#{@activity.id}/genitals"
    end
    
  end
end
