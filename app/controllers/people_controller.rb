class PeopleController < ApplicationController
  unloadable
  before_filter :find_page
  add_breadcrumb "Home", "root_path"
  
  
  def create
    @search = Search.new
    #Use the person's email for login
    params[:person][:user_attributes]["login"] = params[:person][:email]
    @person = Person.new(params[:person])
    params[:person][:user_attributes].merge!({ :name => params[:person][:name], :email => params[:person][:email] })
    params[:person][:person_group_ids] = [PersonGroup.find_by_title("Parent").id]
    @person.confirmed = !@cms_config['site_settings']['member_confirmation']
    logger.info(params[:person][:user_attributes][:login])
    if @person.save 
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