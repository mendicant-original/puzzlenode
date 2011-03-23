class Puzzle < ActiveRecord::Base
  has_many :submissions, :dependent => :destroy
  has_many :comments,    :dependent => :destroy, :order => "created_at"
  has_many :attachments, :dependent => :destroy

  accepts_nested_attributes_for :attachments, :allow_destroy => true

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
      where(["submissions.puzzle_id = ? AND submissions.correct = ?",
              self.id, true]).
      order("submissions.created_at")
  end

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
