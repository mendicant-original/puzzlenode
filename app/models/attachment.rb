class Attachment < ActiveRecord::Base
  belongs_to :puzzle
  
  before_create :save_file
  before_destroy :delete_file
  
  validates_presence_of :puzzle_id
  validates_presence_of :file_name
  
  def file=(tempfile)
    self.file_name = File.basename(tempfile.original_filename)
    @tempfile = tempfile
  end
  
  def file_path
    File.join(Rails.root, 'public', 'attachments', puzzle.id.to_s, file_name)
  end
  
  def directory
    File.join(Rails.root, 'public', 'attachments', puzzle.id.to_s)
  end
  
  def public_path
    File.join('/', 'attachments', puzzle.id.to_s, file_name)
  end
  
  private
  
  def save_file
    FileUtils.mkdir_p(directory)
    File.open(file_path, "wb") { |f| f.write(@tempfile.read) }
  end
  
  def delete_file
    FileUtils.rm(file_path)
  end
end
