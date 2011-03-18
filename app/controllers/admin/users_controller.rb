class Admin::UsersController < Admin::Base
  
  def index
    order_by = []
    order_by << "(SELECT COUNT(*) FROM submissions WHERE correct IS TRUE AND user_id IN (users.id)) DESC"
    order_by << "(SELECT COUNT(*) FROM submissions WHERE user_id IN (users.id)) DESC"
    order_by << "users.created_at"
    
    @users = User.order(order_by.join(",")).paginate(:page => params[:page])
  end
  
end
