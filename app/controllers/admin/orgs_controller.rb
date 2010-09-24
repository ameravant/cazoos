class Admin::OrgsController < AdminController
  def index
    @orgs = Org.all
  end
  
  def new
    @org = Org.new
    @people = Person.all  # In the future we will weed these out to only Organization Owners
    # We will also add an assignment of @suspected_owner (the person who was just created using the admin/people system)
    #    and that person will be pre-selected in the view...maybe
  end
  
  def create
    @org = Org.new(params[:org])
    if @org.save
      redirect_to admin_orgs_path
    else
      render 'new'
    end
  end
  
end