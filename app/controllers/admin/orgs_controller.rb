class Admin::OrgsController < AdminController
  def index
    @orgs = Org.all
  end
  
  def new
    @org = Org.new
    @org.org_owner = OrgOwner.new
    @org.org_owner.user = User.new
  end
end