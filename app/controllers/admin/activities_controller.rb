class Admin::ActivitiesController < AdminController
  before_filter :allow_only_admin_and_org_owners
  before_filter :load_activity_and_reject_if_owner_not_logged_in, :except => [:index, :new, :create]
  before_filter :reject_org_owner_if_org_info_missing_from_URL, :only => [:edit, :update, :index]
  before_filter :reject_org_owner_from_other_org_activities_index, :only => :index

  # GET /admin/organizations/:org_id/activities or
  # GET /admin/activities (only as SuperAdmin)
  def index
    @activities = params[:org_id].nil? ? Activity.all : Activity.all(:conditions => ['org_id=?', params[:org_id]])
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
      redirect_to admin_org_activities_path(@org)
    else
      @activity_categories = ActivityCategory.all
      render 'new'
    end
  end
  
  # GET /admin/organizations/:org_id/activities/:id/edit
  # GET /admin/activities/:id/edit (only as SuperAdmin)
  def edit
    @org = Org.find(params[:org_id]) if !params[:org_id].nil?
    @activity_categories = ActivityCategory.all
  end
  
  # PUT /admin/organizations/:org_id/activities/:id
  # PUT /admin/activities/:id (only as SuperAdmin)
  def update
    @activity = Activity.find(params[:id])
    @org = Org.find(params[:org_id]) if !params[:org_id].nil?
    if @activity.update_attributes(params[:activity])
      flash[:notice] = 'Activity has been successfully updated.'
      redirect_to index_page_with_correct_scope
    else
      @activity_categories = ActivityCategory.all
      render 'edit'
    end
  end
  
  # DELETE /admin/organizations/:org_id/activities/:id
  # DELETE /admin/activities/:id
  def destroy
    @activity.destroy
    respond_to :js
  end
  
  private
  
  # Returns the index page path for either All Activities or "This organization's Activities"
  def index_page_with_correct_scope
    !params[:org_id].nil? ? admin_org_activities_path(@org) : admin_activities_path
  end
  
  # Kicks out anyone who is not either an Admin or an Organization Owner
  def allow_only_admin_and_org_owners
    authorize(['Admin', 'Organization Owner'], 'editing Activities')
  end
  
  # Loads the record, checks to see that either the Admin is logged in or that the logged in OrgOwner owns the record
  def load_activity_and_reject_if_owner_not_logged_in
    @activity = Activity.find(params[:id])
    unless activity_is_mine? or current_user.has_role('Admin')
      authorize(['kick me out'], 'editing that Activity') 
    end
  end
  
  # Disallows OrgOwners from accessing their activities without being in the /admin/organizations/:org_id/... URL namespace
  def reject_org_owner_if_org_info_missing_from_URL
    authorize(['kick me out'], 'Activities Admin') unless !params[:org_id].nil? or current_user.has_role('Admin')
  end
  
  # Disallows OrgOwner from editing, updating or destroying another OrgOwner's activity
  def reject_org_owner_from_other_org_activities_index
    if !params[:org_id].nil?
      authorize(['kick me out'], 'that') unless org_is_mine?
    end
  end
  
  # Returns true if logged-in OrgOwner owns the Organization referred to by :org_id param, false otherwise
  def org_is_mine?
    current_user.has_role('Admin') || Org.find(params[:org_id]).owner.user == current_user
  end
  
  # Returns true if logged-in OrgOwner owns the Activity referred to by :id param, false otherwise
  def activity_is_mine?
    current_user == @activity.org.owner.user
  end
end