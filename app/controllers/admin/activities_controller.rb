class Admin::ActivitiesController < AdminController
  before_filter :allow_only_admin_and_org_owners
  before_filter :load_activity_and_reject_if_owner_not_logged_in, :except => [:index, :new, :create]
  before_filter :reject_org_owner_if_org_info_missing_from_URL, :only => [:edit, :update, :index]
  before_filter :reject_org_owner_from_other_org_activities_index, :only => :index

  # GET /admin/organizations/:org_id/activities or
  # GET /admin/activities (only as SuperAdmin)
  def index
    # Write a scenario to ensure that an Org Owner sees only their own Activities, then rewrite this line
    # @activities = params[:org_id].nil? ? Activity.all : Activity.find_by_org_id(params[:org_id])
    @activities = Activity.all
    @org = Org.find(params[:org_id]) if !params[:org_id].nil?
  end
  
  # GET /admin/organizations/:org_id/activities/new
  def new
    @org = Org.find(params[:org_id])
    @activity = Activity.new
    @activity_categories = ActivityCategory.all
  end
  
  # POST /admin/organizations/:org_id/activities
  def create
    @org = Org.find(params[:org_id])    
    @activity = Activity.new(params[:activity])
    @activity.org = @org
    if @activity.save
      flash[:notice] = 'New Activity successfully created.'
      redirect_to admin_activities_path
    else
      @activity_categories = ActivityCategory.all
      render 'new'
    end
  end
  
  # GET /admin/organizations/:org_id/activities/:id/edit
  # GET /admin/activities/:id/edit (only as SuperAdmin)
  def edit
    @org = Org.find(params[:org_id]) if !params[:org_id].nil?
    # Should not need this following line, since it's loaded in a before_filter
    # @activity = Activity.find(params[:id])
    @activity_categories = ActivityCategory.all
  end
  
  # PUT /admin/organizations/:org_id/activities/:id
  # PUT /admin/activities/:id (only as SuperAdmin)
  def update
    @activity = Activity.find(params[:id])
    @org = Org.find(params[:org_id]) if !params[:org_id].nil?
    if @activity.update_attributes(params[:activity])
      flash[:notice] = 'Activity has been successfully updated.'
      redirect_to !params[:org_id].nil? ? admin_org_activities_path(@org) : admin_activities_path
    else
      @activity_categories = ActivityCategory.all
      render 'edit'
    end
  end
  
  def destroy
  end
  
  private
  
  def allow_only_admin_and_org_owners
    authorize(['Admin', 'Organization Owner'], 'editing Activities')
  end
  
  def load_activity_and_reject_if_owner_not_logged_in
    @activity = Activity.find(params[:id])
    unless activity_is_mine? or current_user.has_role('Admin')
      authorize(['kick me out'], 'editing that Activity') 
    end
  end
  
  def reject_org_owner_if_org_info_missing_from_URL
    authorize(['kick me out'], 'Activities Admin') unless !params[:org_id].nil? or current_user.has_role('Admin')
  end
  
  def reject_org_owner_from_other_org_activities_index
    if !params[:org_id].nil?
      authorize(['kick me out'], 'that') unless org_is_mine?
    end
  end
  
  def org_is_mine?
    current_user.has_role('Admin') || Org.find(params[:org_id]).owner.user == current_user
  end
  
  def activity_is_mine?
    current_user == @activity.org.owner.user
  end
end