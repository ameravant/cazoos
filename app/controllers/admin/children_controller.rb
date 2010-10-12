class Admin::ChildrenController < AdminController  
  before_filter :find_parent
  def new
    @child = Child.new
  end

  def create
    @child = Child.new(params[:child])
    @child.person_id = @person.id
    if @child.save
      flash[:notice] = 'You have added a child.'
      redirect_to edit_admin_person_path(@parent)
    else
      render 'new'
    end
  end
  
  private
    def find_parent
      @person = Person.find(current_user.person_id)
    end
  
end