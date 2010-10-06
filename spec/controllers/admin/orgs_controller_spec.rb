require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe Admin::OrgsController do
  describe "index" do
    it "should route correctly" do
      route_for(:controller => "admin/orgs", :action => "index").should == admin_orgs_path
    end
  end
end