class Admin::ActivityCategoriesController < AdminController
  def index
    @activity_categories = ActivityCategory.all
  end
  
  def new
    @activity_category = ActivityCategory.new
  end
  
  def create
    @activity_category = ActivityCategory.new(params[:activity_category])
    if @activity_category.save
      flash[:notice] = "The new activity category was successfully created."
      redirect_to admin_activity_categories_path
    else
      render 'new'
    end
  end
  
end