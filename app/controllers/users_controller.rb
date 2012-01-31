class UsersController < ApplicationController
  before_filter :find_user

  def show
    unless @user
      raise ActionController::RoutingError.new('Not Found')
    else
      @leaderboard = @user.leaderboard_position
    end
  end

  def update
    if @user.update_attributes(params[:user])
      flash[:notice] = "User sucessfully updated"
      redirect_to user_path(@user.nickname)
    else
      render :edit
    end
  end


  private

  def find_user
    @user = User.find_by_nickname(params[:id])
  end
end
