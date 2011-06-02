ActiveAdmin.register User do

  #index =>
  #order_by << "(SELECT COUNT(*) FROM submissions WHERE correct IS TRUE AND user_id IN (users.id)) DESC"
  #order_by << "(SELECT COUNT(*) FROM submissions WHERE user_id IN (users.id)) DESC"
  #order_by << "users.created_at"

  index do
    column :name, :sortable => :name do |user|
      link_to user.name, edit_admin_user_path(user)
    end
    column 'Solved' do |user|
      user.submissions.correct.count.to_s
    end
    column 'Attempted' do |user|
      user.submissions.count.to_s
    end
    column 'Member since', :created_at
  end

  form do |f|
    f.inputs do
      f.input :name
      f.input :nickname, :as => :string
      f.input :email
      f.input :admin
      f.input :draft_access
    end
    f.buttons
  end

end
