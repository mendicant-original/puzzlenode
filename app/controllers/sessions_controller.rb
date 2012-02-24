class SessionsController < ApplicationController

  def new
    provider = Rails.env.production? ? "github" : "developer"
    redirect_to("/auth/#{provider}")
  end

  def create
    auth = request.env['omniauth.auth']

    unless @auth = Authorization.find_from_hash(auth)
      # Create a new user or add an auth to existing user, depending on
      # whether there is already a user signed in.
      @auth = Authorization.create_from_hash(auth, current_user)
    end
    # Log the authorizing user in.
    self.current_user = @auth.user

    redirect_back_or_default root_path
  end

  def destroy
    self.current_user = nil

    redirect_to root_path
  end

  def failure
    flash[:error] = "There was a problem logging in. Please try again"

    self.current_user = nil # Try destroying the current_user

    redirect_to root_path
  end
end
