class ApplicationController < ActionController::Base
  protect_from_forgery

  private

  def authenticate_admin_user!
    unless current_user.try(:admin)
      flash[:error] = "You are not authorize to view this area"
      redirect_to root_path
    end
  end

  def current_admin_user
    current_user if current_user.try(:admin)
  end

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
      store_location
      redirect_to login_path
    end
  end

  def store_location
    session[:return_to] = request.request_uri
  end

  def redirect_back_or_default(default)
    redirect_to(session[:return_to] || default)
    session[:return_to] = nil
  end
end
