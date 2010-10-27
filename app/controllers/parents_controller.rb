class ParentsController < ApplicationController
  unloadable
  before_filter :find_page
  add_breadcrumb "Home", "root_path"
  
  def new
    @parent = Parent.new
    @parent.build_user
  end
  
  def create
    @search = Search.new
    #Use the parent's email for login
    params[:parent][:user_attributes]["login"] = params[:parent][:email]
    @parent = Parent.new(params[:parent])
    params[:parent][:user_attributes].merge!({ :name => params[:parent][:name], :email => params[:parent][:email] })
    params[:parent][:person_group_ids] = []
    @parent.confirmed = true
    if @parent.save
      @parent.person_groups = [ PersonGroup.find_by_title("Parent") ]
      @parent.save
      redirect_to new_session_path
      flash[:notice] = "Thanks for joining! Please log in to complete your profile."
    else
      render :action => "new"
    end
  end

  private

  def find_page
    @page = Page.find_by_permalink("inquire")
  end
end
