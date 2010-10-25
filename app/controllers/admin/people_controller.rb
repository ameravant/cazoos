class Admin::PeopleController < AdminController  
  before_filter :find_parent

  def show
  end
  
  private
    def find_parent
      @parent = Person.find(current_user.person_id)
    end
  
end