class LeaderboardController < ApplicationController
  
  def index
    @users = User.leaderboard

    @top_three = []
    @top_three << [:gold,   @users.shift]
    @top_three << [:silver, @users.shift]
    @top_three << [:bronze, @users.shift]
    @local_users = current_user.local_leaderboard unless current_user.nil?
  end

end
