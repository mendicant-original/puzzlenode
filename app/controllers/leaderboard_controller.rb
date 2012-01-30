class LeaderboardController < ApplicationController
  
  def index
    @users = User.leaderboard

    @top_three = []
    @top_three << [:gold,   @users.shift]
    @top_three << [:silver, @users.shift]
    @top_three << [:bronze, @users.shift]
  end

  def local
    @top_three = []
    redirect_to :action => 'index' and return if current_user.nil?
    @users = current_user.local_leaderboard
    render :index
  end
end
