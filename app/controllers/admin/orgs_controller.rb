class Admin::OrgsController < AdminController
  before_filter :block_intruders
  before_filter :org_is_mine?, :except => [:index, :new, :create]
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
    @owners = PersonGroup.find_by_title('Organization Owner').people    
  end
  
  def block_intruders
    authorize(['Admin', 'Organization Owner'], 'editing Organizations')
  end
  
  def org_is_mine?
    @org = Org.find(params[:id])
    authorize(['non-existent-role'], 'editing that Organization') unless current_user.id == @org.owner.user.id
  end
end