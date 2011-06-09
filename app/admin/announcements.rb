ActiveAdmin.register Announcement, :sort_order => 'created_at_desc' do

  index do
    column :title do |announcement|
      link_to announcement.title, edit_admin_announcement_path(announcement)
    end
    column :created_at
  end

  form do |f|
    f.inputs do
      f.input :author, :as => :select, :collection => User.admin
      f.input :title, :as => :string
      f.input :body
    end
    f.buttons
  end

end
