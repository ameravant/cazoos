class Admin::OrgOwnersController < AdminController  
  def new
    @owner = OrgOwner.new
    @owner.build_user
  end
  def create
    params[:org_owner][:user_attributes]["login"] = params[:org_owner][:email]
    @owner = OrgOwner.new(params[:org_owner])
    @owner.person_group_ids ||= []
    @owner.person_group_ids = @owner.person_group_ids << PersonGroup.find_by_name("admin").id
    if @owner.save
      redirect_to new_admin_org_type_path
      session[:org_owner_id] = @owner.id
      flash[:notice] = "Is the type of this Organization in the list? If not create the new type below."
    else
      render :new
    end
  end
  def index
    add_breadcrumb "People"
    @people_count = OrgOwner.active.all
    @people_count = PersonGroup.find(params[:search][:group]).people if params[:search] and !params[:search][:group].blank?
    @role_groups = PersonGroup.is_role
    @groups = PersonGroup.is_subscription
    unless params[:q].blank?
      search_builder = "OrgOwner.active"
      for parameter in params[:q].to_s.split
        search_builder << ".first_name_or_last_name_or_email_like(\"#{parameter}\")"
      end
      @people_count = eval(search_builder)
    end
    @people = @people_count.paginate(:page => params[:page], :per_page => 25)
    @unconfirmed_people = OrgOwner.active.unconfirmed.paginate(:page => params[:page], :per_page => 25)

    # Export CSV
    respond_to do |wants|
      require 'fastercsv'
      wants.html
      wants.csv do
        @outfile = "people_" + Time.now.strftime("%m-%d-%Y") + ".csv"
        csv_data = FasterCSV.generate do |csv|
          csv << ["First Name", "Last Name", "Email", "Company", "Phone", "Address", "City", "State", "Zip Code"]
          @people_count.each do |person|
            csv << [person.first_name, person.last_name, person.email, person.company, person.phone, person.address1, person.city, person.city, person.state, person.zip]
          end
        end
        send_data csv_data,
        :type => 'text/csv; charset=iso-8859-1; header=present',
        :disposition => "attachment; filename=#{@outfile}"
        flash[:notice] = "Export complete!"
      end
    end
  end
  
end
