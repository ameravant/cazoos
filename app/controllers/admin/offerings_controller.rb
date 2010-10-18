class Admin::OfferingsController < AdminController
  before_filter :allow_only_admin_and_org_owners
  before_filter :load_offering_and_reject_if_owner_not_logged_in, :except => [:index, :new, :create]
  before_filter :reject_org_owner_if_org_info_missing_from_URL, :only => [:edit, :update, :index]
  before_filter :reject_org_owner_from_other_org_offerings_index, :only => :index

  # GET /admin/organizations/:org_id/offerings or
  # GET /admin/offerings (only as SuperAdmin)
  def index
    @offerings = params[:org_id].nil? ? Offering.all : Offering.all(:conditions => ['org_id=?', params[:org_id]])
    @org = Org.find(params[:org_id]) if !params[:org_id].nil?
  end
  
  # GET /admin/organizations/:org_id/offerings/new
  def new
    @org = Org.find(params[:org_id])
    @offering = Offering.new
    @activity_categories = ActivityCategory.all
  end
  
  # POST /admin/organizations/:org_id/offerings
  def create
    @org = Org.find(params[:org_id])    
    @offering = Offering.new(params[:offering])
    @offering.org = @org
    if @offering.save
      flash[:notice] = 'New Offering successfully created.'
      redirect_to admin_org_offerings_path(@org)
    else
      @activity_categories = ActivityCategory.all
      render 'new'
    end
  end
  
  # GET /admin/organizations/:org_id/offerings/:id
  # GET /admin/offerings/:id (only as SuperAdmin)
  def show
    @org = Org.find(params[:org_id]) if !params[:org_id].nil?    
  end
  
  # GET /admin/organizations/:org_id/offerings/:id/edit
  # GET /admin/offerings/:id/edit (only as SuperAdmin)
  def edit
    @org = Org.find(params[:org_id]) if !params[:org_id].nil?
    @activity_categories = ActivityCategory.all
  end
  
  # PUT /admin/organizations/:org_id/offerings/:id
  # PUT /admin/offerings/:id (only as SuperAdmin)
  def update
    @offering = Offering.find(params[:id])
    @org = Org.find(params[:org_id]) if !params[:org_id].nil?
    if @offering.update_attributes(params[:offering])
      flash[:notice] = 'Offering has been successfully updated.'
      redirect_to index_page_with_correct_scope
    else
      @activity_categories = ActivityCategory.all
      render 'edit'
    end
  end
  
  # DELETE /admin/organizations/:org_id/offerings/:id
  # DELETE /admin/offerings/:id
  def destroy
    @offering.destroy
    respond_to :js
  end
  
  private
  
  # Returns the index page path for either All Activities or "This organization's Activities"
  def index_page_with_correct_scope
    !params[:org_id].nil? ? admin_org_offerings_path(@org) : admin_offerings_path
  end
  
  # Kicks out anyone who is not either an Admin or an Organization Owner
  def allow_only_admin_and_org_owners
    authorize(['Admin', 'Organization Owner'], 'editing Activities')
  end
  
  # Loads the record, checks to see that either the Admin is logged in or that the logged in OrgOwner owns the record
  def load_offering_and_reject_if_owner_not_logged_in
    @offering = Offering.find(params[:id])
    unless offering_is_mine? or current_user.has_role('Admin')
      authorize(['kick me out'], 'editing that Offering') 
    end
  end
  
  # Disallows OrgOwners from accessing their offerings without being in the /admin/organizations/:org_id/... URL namespace
  def reject_org_owner_if_org_info_missing_from_URL
    authorize(['kick me out'], 'Activities Admin') unless !params[:org_id].nil? or current_user.has_role('Admin')
  end
  
  # Disallows OrgOwner from editing, updating or destroying another OrgOwner's offering
  def reject_org_owner_from_other_org_offerings_index
    if !params[:org_id].nil?
      authorize(['kick me out'], 'that') unless org_is_mine?
    end
  end
  
  # Returns true if logged-in OrgOwner owns the Organization referred to by :org_id param, false otherwise
  def org_is_mine?
    current_user.has_role('Admin') || Org.find(params[:org_id]).owner.user == current_user
  end
  
  # Returns true if logged-in OrgOwner owns the Offering referred to by :id param, false otherwise
  def offering_is_mine?
    current_user == @offering.org.owner.user
  end
end