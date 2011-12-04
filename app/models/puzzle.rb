class Puzzle < ActiveRecord::Base
  acts_as_taggable

  has_many :submissions, :dependent => :destroy
  has_many :comments,    :dependent => :destroy, :order => "created_at"
  has_many :attachments, :dependent => :destroy

  accepts_nested_attributes_for :attachments, :allow_destroy => true

  validates_presence_of   :name, :short_description, :description, :slug
  validates_uniqueness_of :slug

  after_save :save_to_file
  before_destroy :delete_file


  def self.published(user=nil)
    if user && (user.draft_access || user.admin)
      self
    else
      where(:published => true)
    end
  end

  def to_param
    slug
  end

  def file=(tempfile)
    write_attribute :fingerprint, sha1(tempfile)
  end

  def valid_solution?(tempfile)
    fingerprint == sha1(tempfile)
  end

  def answered_correctly?(user)
    if user && user.solution_for(self)
      true
    else
      false
    end
  end

  def solved_by
    User.includes(:submissions).
      where("submissions.puzzle_id = ? AND submissions.correct = ?",
            self.id, true).
      order("submissions.created_at")
  end

  # File Management

  def save_to_file
    delete_file if file_exists?
    save_file
  end

  def description_as_markdown
    self.name + "\n\n" + self.description
  end

  def file_name
    self.name.titleize.gsub(" ", "").underscore + ".markdown"
  end

  def file_path
    File.join(directory, file_name)
  end

  def directory
    File.join(Rails.root, 'public', 'puzzles', self.id.to_s)
  end

  def save_file
    FileUtils.mkdir_p(directory)
    File.open(file_path, "wb") { |f| f.write(description_as_markdown) }
  end

  def delete_file
    FileUtils.rm(file_path)
  end

  def file_exists?
    File.exists?(file_path)
  end

  # def public_path
  #   "/puzzles/#{puzzle.id}.markdown"
  # end

  private

  def sha1(tempfile)
    Digest::SHA1.hexdigest(normalize_file(tempfile.read))
  end

  def normalize_file(str)
    str.gsub!("\r\n", "\n")
    str << "\n" unless str[-1] == "\n"
    str
  end
end
