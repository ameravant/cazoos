class Admin::OrgsController < AdminController
  def index
    @orgs = Org.all
  end
  
  def new
    @org = Org.new
    @org.org_owner = OrgOwner.new
    @org.org_owner.user = User.new
  end
  
  def create
    flash[:error] = "There were errors on the page"
    redirect_to :action => 'new'
  end
end