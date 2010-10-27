class Admin::OrgsController < AdminController
  before_filter :block_intruders
  before_filter :load_org_and_reject_if_owner_not_logged_in, :except => [:index, :new, :create]
  before_filter :require_admin_login_for_index, :only => :index
  before_filter :load_supporting_resources, :only => [:new, :create, :edit, :update]
    
  def index
    @orgs = Org.all
  end
  
  def new
    @org = Org.new
  end
  
   def create
    @org = Org.new(params[:org])
    if @org.save
      flash[:notice] = "You have successfully created a new organization."
      redirect_to admin_orgs_path
    else
      render 'new'
    end
  end
  
  def edit
  end
  
  def update
    if @org.update_attributes(params[:org])
      flash[:notice] = "You have successfully updated the organization."
      redirect_to admin_orgs_path
    else
      render 'edit'
    end
  end
  
  def destroy
    @org.destroy
    respond_to :js
  end
  
  private
  
  def load_supporting_resources
    @org_types = OrgType.all
    @owners = OrgOwner.all
    #PersonGroup.find_by_title('Organization Owner').people    
  end
  
  def block_intruders
    authorize(['Admin', 'Organization Owner'], 'editing Organizations')
  end
  
  def load_org_and_reject_if_owner_not_logged_in
    @org = Org.find(params[:id])
    unless org_is_mine? or current_user.has_role('Admin')
      authorize(['kick me out'], 'editing that Organization') 
    end
  end
  
  def require_admin_login_for_index
    authorize(['kick me out'], 'that') unless current_user.has_role('Admin')
  end
  
  def org_is_mine?
    current_user == @org.owner.user
  end
end