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
    @org = Org.new(params[:org])
    if @org.save
      redirect_to admin_orgs_path
    else
      @org = Org.new
      @org.org_owner = OrgOwner.new
      @org.org_owner.user = User.new
      render 'new'
    end
  end
  
end