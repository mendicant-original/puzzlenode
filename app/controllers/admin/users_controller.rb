class Admin::UsersController < Admin::Base
  before_filter :find_user, :only => [:edit, :update]
  
  def index
    order_by = []
    order_by << "(SELECT COUNT(*) FROM submissions WHERE correct IS TRUE AND user_id IN (users.id)) DESC"
    order_by << "(SELECT COUNT(*) FROM submissions WHERE user_id IN (users.id)) DESC"
    order_by << "users.created_at"
    
    @users = User.order(order_by.join(",")).paginate(:page => params[:page])
  end
  
  def edit
    
  end
  
  def update
    if @user.update_attributes(params[:user])
      flash[:notice] = "User sucessfully updated."
      redirect_to admin_users_path
    else
      render :action => :edit
    end
  end
  
  private
  
  def find_user
    @user = User.find(params[:id])
  end
  
end
