class Attachment < ActiveRecord::Base
  mount_uploader :file, FileUploader

  belongs_to :puzzle
  before_destroy :remove_file!

  def file_name
    File.basename(file.to_s)
  end

end
