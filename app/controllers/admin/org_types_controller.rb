 class Admin::OrgTypesController < AdminController
  before_filter :require_super_user_login
  
  def index
    @org_types = OrgType.all
  end
  
  def new
    @org_type = OrgType.new
    @org_types = OrgType.all
  end
  
  def create
    @org_types = OrgType.all
    @org_type = OrgType.new(params[:org_type])
    if @org_type.save
      flash[:notice] = "The new organization type was successfully created."
      if session[:org_owner_id]
        redirect_to new_admin_org_path
      else
        redirect_to admin_org_types_path
      end
    else
      render :action => 'new'
    end
  end
  
  def edit
    @org_type = OrgType.find(params[:id])
  end
  
  def update
    @org_type = OrgType.find(params[:id])
    if @org_type.update_attributes(params[:org_type])
      flash[:notice] = "The organization type was successfully updated."
      redirect_to admin_org_types_path
    else
      render 'edit'
    end
  end
  
  def destroy
    @org_type = OrgType.find(params[:id])
    @org_type.destroy
    respond_to :js
  end
  
  private
  
  # def require_super_user_login
  #   authorize('Admin', 'editing Organization Types')
  # end
  # 
end
