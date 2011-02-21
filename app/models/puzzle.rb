class Puzzle < ActiveRecord::Base
  has_many :submissions
  has_many :comments
  has_many :attachments

  def file=(tempfile)
    write_attribute :fingerprint, sha1(tempfile)
  end

  def valid_solution?(tempfile)
    fingerprint == sha1(tempfile)
  end

  private

  def sha1(tempfile)
    Digest::SHA1.hexdigest(tempfile.read)
  end
end
