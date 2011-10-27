class UsersController < ApplicationController
  before_filter :find_user

  def show
    unless @user
      flash[:error] = "Sorry, we can't find that user!"
      redirect_to root_path
    else
      @leaderboard = @user.leaderboard_position(User.count)
    end
  end

  private

  def find_user
    @user = User.find_by_nickname(params[:id])
  end
end
