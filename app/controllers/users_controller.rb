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
