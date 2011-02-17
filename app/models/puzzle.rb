class Puzzle < ActiveRecord::Base
  has_many :submissions
  has_many :comments

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

  private

  def sha1(tempfile)
    Digest::SHA1.hexdigest(tempfile.read)
  end
end
