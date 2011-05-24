class LeaderboardController < ApplicationController
  
  def index
    @users = User.leaderboard
  end
end
