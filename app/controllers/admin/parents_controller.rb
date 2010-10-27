class Admin::ParentsController < AdminController  
  before_filter :find_parent

  def show
  end
  
  private
    def find_parent
      @parent = Parent.find(current_user.person_id)
    end
  
end