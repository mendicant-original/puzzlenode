class Attachment < ActiveRecord::Base
  belongs_to :puzzle

  before_save    :save_file
  before_destroy :delete_file

  validates_presence_of   :file_name
  validates_uniqueness_of :file_name, :scope => :puzzle_id

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
    "/puzzles/#{puzzle.slug}/attachments/#{file_name}"
  end

  private

  def save_file
    if puzzle && @tempfile
      FileUtils.mkdir_p(directory)
      File.open(file_path, "wb") { |f| f.write(@tempfile.read) }
    end
  end

  def delete_file
    FileUtils.rm(file_path) if File.exists?(file_path)
  end
end
