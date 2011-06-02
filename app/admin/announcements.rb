ActiveAdmin.register Announcement, :sort_order => 'created_at_desc' do

  form do |f|
    f.inputs do
      f.input :author
      f.input :title, :as => :string
      f.input :body
    end
    f.buttons
  end

end
