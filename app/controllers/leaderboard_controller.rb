class LeaderboardController < ApplicationController
  
  def index
    order_by = "(SELECT COUNT(*) FROM submissions WHERE correct IS TRUE AND user_id = users.id AND puzzle_id >= 10) DESC"
    
    @users = User.where(:contestant => true).order(order_by).limit(10)
  end
end
