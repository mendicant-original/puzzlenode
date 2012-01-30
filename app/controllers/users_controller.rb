class UsersController < ApplicationController
  before_filter :find_user

  def show
    unless @user
      raise ActionController::RoutingError.new('Not Found')
    else
      @leaderboard = @user.leaderboard_position
    end
  end

  private

  def find_user
    @user = User.find_by_nickname(params[:id])
  end
end
