class Puzzle < ActiveRecord::Base
  has_many :submissions
  has_many :comments, :order => "created_at"
  has_many :attachments

  accepts_nested_attributes_for :attachments, :allow_destroy => true

  def file=(tempfile)
    write_attribute :fingerprint, sha1(tempfile)
  end

  def valid_solution?(tempfile)
    fingerprint == sha1(tempfile)
  end
  
  def answered_correctly?(user)
    if user && user.submissions.where(:puzzle_id => self.id, :correct => true).any?
      true
    else
      false
    end
  end
  
  def solved_by
    User.includes(:submissions).
      where(["submissions.puzzle_id = ? AND submissions.correct = ?",
              self.id, true])
  end

  private

  def sha1(tempfile)
    Digest::SHA1.hexdigest(tempfile.read)
  end
end
