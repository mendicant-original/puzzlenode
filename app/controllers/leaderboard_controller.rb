class LeaderboardController < ApplicationController
  
  def index
    @users = User.leaderboard

    @top_three = []
    @top_three << [:gold,   @users.shift]
    @top_three << [:silver, @users.shift]
    @top_three << [:bronze, @users.shift]
  end
end
