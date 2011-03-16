class Admin::UsersController < Admin::Base
  
  def index
    @users = User.order("created_at").paginate(:page => params[:page])
  end
  
end
