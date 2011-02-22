class User < ActiveRecord::Base
  has_many :authorizations
  has_many :announcements, :foreign_key => "author_id"
  has_many :submissions
  
  def self.create_from_hash!(hash)
    create(:name => hash['user_info']['name'])
  end
  
  def solution_for(puzzle)
    return if puzzle.nil?
    submissions.where(:puzzle_id => puzzle.id, :correct => true).first
  end
end
