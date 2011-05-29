ActiveAdmin.register Announcement do

  #index => order("created_at DESC")

  form do |f|
    f.inputs do
      f.input :author
      f.input :title, :as => :string
      f.input :body
    end
    f.buttons
  end

end
