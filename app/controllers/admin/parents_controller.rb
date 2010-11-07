class Admin::ParentsController < AdminController  
  unloadable
  before_filter :find_parent, :only => [:show]

  def show
  end
  
  def edit
    @parent = Parent.find(params[:id])
  end
  
  def update
    @parent = Parent.find(params[:id])
    if @parent.update_attributes(params[:parent]) && @parent.user.update_attributes(params[:user])
      flash[:notice] = 'You have successfully updated your information.'
      redirect_to admin_parent_path(@parent)
    else
      render :action => "edit"
    end
  end
  
  private
  
  def find_parent
    @parent = Parent.find(current_user.person_id)
  end
  
end
