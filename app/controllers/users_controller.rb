class UsersController < ApplicationController

  def show
    @user = User.find_by_nickname(params[:id])

    unless @user
      raise ActionController::RoutingError.new('Not Found')
    else
      @leaderboard = @user.leaderboard_position
    end
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user

    if @user.update_attributes(params[:user])
      flash[:notice] = "User sucessfully updated"
      redirect_to user_path(@user.nickname)
    else
      render :edit
    end
  end
end
