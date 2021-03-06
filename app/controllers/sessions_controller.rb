class SessionsController < ApplicationController
  unloadable # http://dev.rubyonrails.org/ticket/6001

  def new
    self.current_user.forget_me if logged_in?
    cookies.delete :auth_token
    reset_session
    self.current_user = nil
  end

  def create
    self.current_user = User.authenticate(params[:login], params[:password])
    if logged_in?
      if params[:remember_me] == "1"
        current_user.remember_me unless current_user.remember_token?
        cookies[:auth_token] = { :value => self.current_user.remember_token , :expires => self.current_user.remember_token_expires_at }
      end
      flash[:error] = nil
      if current_user.is_admin?
        redirect_back_or_default('/admin')
      elsif current_user.person.is_a?(Parent) 
        redirect_to admin_parent_path(current_user.person)
      elsif current_user.person.is_a?(OrgOwner)
        redirect_back_or_default('/admin')
      else
        redirect_back_or_default('/')
      end
    else
      flash[:error] = "Your account information could not be verified. Please try again."
      render :action => 'new'
    end
  end

end
