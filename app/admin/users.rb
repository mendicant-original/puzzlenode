ActiveAdmin.register User do

  #index =>
  #order_by << "(SELECT COUNT(*) FROM submissions WHERE correct IS TRUE AND user_id IN (users.id)) DESC"
  #order_by << "(SELECT COUNT(*) FROM submissions WHERE user_id IN (users.id)) DESC"
  #order_by << "users.created_at"
  
  #search => name || nickname

  form do |f|
    f.inputs do
      f.input :name
      f.input :nickname,    :as => :string
      f.input :draft_access
      f.input :contestant
    end
    f.buttons
  end

end
