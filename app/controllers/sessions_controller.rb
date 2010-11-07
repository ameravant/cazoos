class SessionsController < ApplicationController
  unloadable # http://dev.rubyonrails.org/ticket/6001

  def new
    self.current_user.forget_me if logged_in?
    cookies.delete :auth_token
    reset_session
    self.current_user = nil
  end

  def create
    current_user = User.authenticate(params[:login], params[:password])
    if @cms_config['site_settings']['require_login_for_comments']
      session[:return_to] = request.referer
    end
    if logged_in?
      if params[:remember_me] == "1"
        current_user.remember_me unless current_user.remember_token?
        cookies[:auth_token] = { :value => self.current_user.remember_token , :expires => self.current_user.remember_token_expires_at }
      end
      flash[:error] = nil
      if current_user.is_admin?
        redirect_back_or_default('/admin')
      elsif current_user.is_a?(Parent)
        redirect_to admin_parent_path(current_user.person)
      else
        redirect_back_or_default('/')
      end
    else
      flash[:error] = "Your account information could not be verified. Please try again."
      render :action => 'new'
    end
  end

end
