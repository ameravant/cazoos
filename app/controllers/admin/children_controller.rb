class Admin::ChildrenController < AdminController
  unloadable
  before_filter :find_parent

  def new
    @child = Child.new
    @child.build_detail
  end

  def edit
    @child = Child.find(params[:id], :conditions => ['parent_id=?', params[:parent_id]] )
  end

  def update
    @child = Child.find(params[:id], :conditions => ['parent_id=?', params[:parent_id]] )
    if @child.update_attributes(params[:child])
      flash[:notice] = "You have successfully update your child's details"
      redirect_to admin_parent_path(@parent)
    else
      render 'edit'
    end
  end

  def create
    parent = Parent.find(params[:parent_id])
    @child = parent.children.build(params[:child])
    if @child.save
      flash[:notice] = 'You have added a child.'
      redirect_to admin_parent_path(@parent)
    else
      render 'new'
    end
  end
  
  private
    def find_parent
      @parent = Parent.find(params[:parent_id])
    end
  
end