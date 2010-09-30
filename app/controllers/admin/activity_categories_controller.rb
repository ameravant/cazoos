class Admin::ActivityCategoriesController < AdminController
  before_filter :load_record

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

  def edit  
  end
  
  def update
    if @activity_category.update_attributes(params[:activity_category])
      flash[:notice] = "The activity category was successfully updated."
      redirect_to admin_activity_categories_path
    else
      render 'edit'
    end  
  end
  
  def destroy
    @activity_category.destroy
    respond_to :js
  end
  
  private
  
  def load_record
    @activity_category = ActivityCategory.find(params[:id]) if !params[:id].nil?
  end
  
end