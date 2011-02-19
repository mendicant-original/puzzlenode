class ApplicationController < ActionController::Base
  protect_from_forgery
  
  protected

  def current_user
    @current_user ||= User.find_by_id(session[:user_id])
  end

  def signed_in?
    !!current_user
  end

  helper_method :current_user, :signed_in?

  def current_user=(user)
    @current_user = user
    session[:user_id] = user.try(:id)
  end
  
  def user_required
    unless signed_in?
      flash[:error] = "Please sign in to continue!"
      redirect_to login_path
    end
  end
end
