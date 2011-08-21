ActiveAdmin.register Puzzle, :sort_order => 'created_at_asc' do

  index do
    column :name do |puzzle|
      link_to puzzle.name, edit_admin_puzzle_path(puzzle)
    end
    column :released_on
    column 'Tags', :tag_list
    column :created_at
    column 'Submissions' do |puzzle|
      puzzle.submissions.count.to_s
    end
    column 'Comments' do |puzzle|
      link_to "#{puzzle.comments.count} Comments", puzzle_comments_path(puzzle)
    end
    column do |puzzle|
      link_to "View", puzzle_path(puzzle)
    end
  end

  form :html => { :multipart => true } do |f|
    f.inputs do
      f.input :name,               :as => :string
      f.input :created_by
      f.input :created_by_url
      f.input :released_on
      f.input :tag_list,           :label => "Tags"
      f.input :short_description,  :as => :string
      f.input :description
      f.input :notice
      f.input :fingerprint,        :as => :string  if f.object.fingerprint
      f.input :file,               :as => :file,  :label => "Solution File"

      f.has_many :attachments do |attachment|
        if attachment.object.new_record?
          attachment.input :file, :as => :file
        else
          attachment.input :file_name, :input_html => { :disabled => true }
          attachment.input :_destroy, :as => :boolean
        end
      end
    end

    f.buttons
  end

end
