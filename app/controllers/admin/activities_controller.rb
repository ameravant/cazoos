class Admin::ActivitiesController < AdminController
  def index
    # Write a scenario to ensure that an Org Owner sees only their own Activities, then rewrite this line
    @activities = Activity.all
  end
  
  def new
    @activity = Activity.new
    @activity_categories = ActivityCategory.all
  end
  
  def create
    @activity = Activity.new(params[:activity])
    if @activity.save
      flash[:notice] = 'New Activity successfully created.'
      redirect_to admin_activities_path
    else
      @activity_categories = ActivityCategory.all
      render 'new'
    end
  end
  
  def edit
    # Write a scenario to ensure that an Org Owner sees only their own Activities, then rewrite this line
    @activity = Activity.find(params[:id])
    @activity_categories = ActivityCategory.all
  end
  
  def update
    @activity = Activity.find(params[:id])
    # logger.info("Here it comes:\n" + params[:activity].to_a.to_s)
    # logger.info("\nFun has ID: " + ActivityCategory.find_by_name('Fun').id.to_s)
    if @activity.update_attributes(params[:activity])
      flash[:notice] = 'Activity has been successfully updated.'
      redirect_to admin_activities_path
    else
      @activity_categories = ActivityCategory.all
      render 'edit'
    end
  end
  
end