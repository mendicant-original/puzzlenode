ActiveAdmin.register Puzzle, :sort_order => 'created_at_asc' do

  form :html => { :multipart => true } do |f|
    f.inputs do
      f.input :name,               :as => :string
      f.input :created_by
      f.input :created_by_url
      f.input :released_on
      f.input :short_description,  :as => :string
      f.input :description
      f.input :fingerprint,        :as => :string  if f.object.fingerprint
      f.input :file,               :as => :file,  :label => "Solution File"

      f.has_many :attachments do |attachment|
        if attachment.object.file_name.blank?
          attachment.input :file, :as => :file
        else
          attachment.input :file_name
        end
      end
    end

    f.buttons
  end

end
