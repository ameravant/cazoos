class Admin::OrgCategoriesController < AdminController
  def index
    @org_categories = OrgCategory.all
  end
  
  def new
    @org_category = OrgCategory.new
  end
  
  def create
    @org_category = OrgCategory.new(params[:org_category])
    if @org_category.save
      flash[:notice] = "The new organization category was successfully created."
      redirect_to admin_org_categories_path
    else
      render 'new'
    end
  end
  
  def edit
    @org_category = OrgCategory.find(params[:id])
  end
  
  def update
    @org_category = OrgCategory.find(params[:id])
    if @org_category.update_attributes(params[:org_category])
      flash[:notice] = "The category was successfully updated."
      redirect_to admin_org_categories_path
    else
      render 'edit'
    end
  end
  
  def destroy
    @org_category = OrgCategory.find(params[:id])
    if @org_category.delete
      flash[:notice] = "The '#{@org_category.title}' category was successfully deleted."
      redirect_to admin_org_categories_path
    end
  end
end