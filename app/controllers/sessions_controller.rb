class SessionsController < ApplicationController
  unloadable # http://dev.rubyonrails.org/ticket/6001

  def create
    self.current_user = User.authenticate(params[:login], params[:password])
    if @cms_config['site_settings']['require_login_for_comments']
      session[:return_to] = request.referer
    end
    if logged_in?
      if params[:remember_me] == "1"
        current_user.remember_me unless current_user.remember_token?
        cookies[:auth_token] = { :value => self.current_user.remember_token , :expires => self.current_user.remember_token_expires_at }
      end
      flash[:error] = nil
      if self.current_user.has_role("admin")
        redirect_back_or_default('/admin')
      elsif self.current_user.has_role("Parent")
        redirect_to edit_admin_person_path(self.current_user.person)
      else
        redirect_back_or_default('/')
      end
    else
      flash[:error] = "Your account information could not be verified. Please try again."
      render :action => 'new'
    end
  end

end