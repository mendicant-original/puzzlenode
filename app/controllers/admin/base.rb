class Admin::Base < ApplicationController
  before_filter :admin_required

  private
  
  def admin_required
    unless current_user && current_user.admin?
      flash[:error] = "Administrator required"
      redirect_to root_path
    end
  end
end
