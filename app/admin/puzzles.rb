ActiveAdmin.register Puzzle do

  #index => order("created_at")

  form do |f|
    f.inputs do
      f.input :name,               :as => :string
      f.input :created_by
      f.input :created_by_url
      f.input :released_on
      f.input :short_description,  :as => :string
      f.input :description
      f.input :fingerprint,        :as => :string  #if @puzzle.fingerprint
      f.input :file,               :as => :file,  :label => "Solution File"
    end

    f.inputs "Input Files" do

#      = f.fields_for :attachments do |a|
#        %p
#        if a.object.file_name.blank?
#            = a.label :file, "File"
#            = a.file_field :file
#        else
#            = a.object.file_name
#            
#            = a.link_to_remove "Remove"
#            
#            = f.link_to_add "Add an input file", :attachments

        end

    f.buttons
  end

end
