class AdminController < ApplicationController
  private
  
  def require_super_user_login
    authorize('Admin', 'editing Organization Types')  
  end
end