class User < ActiveRecord::Base
  has_many :authorizations, :dependent => :destroy
  has_many :announcements,  :dependent => :destroy, :foreign_key => "author_id"
  has_many :submissions,    :dependent => :destroy

  scope :contestant, where(:contestant => true)
  
  attr_protected :admin
  
  def self.create_from_hash!(hash)    
    create(:name     => hash['user_info']['name'], 
           :nickname => hash['user_info']['nickname'])
  end

  def name
    read_attribute(:name) || nickname || "Anonymous ##{id}"
  end

  def refresh_names(hash)
    return if nickname

    update_attributes(:name      => hash['user_info']['name'],
                      :nickname  => hash['user_info']['nickname'])
  end
  
  def solution_for(puzzle)
    return if puzzle.nil?
    submissions.where(:puzzle_id => puzzle.id, :correct => true).first
  end

  def self.leaderboard(limit=10)
    solutions = Submission.correct.select('user_id, SUM(EXTRACT(EPOCH FROM created_at)) AS elapsed, COUNT(*) AS solved').group('user_id')
    attempts  = Submission.select('user_id, COUNT(*) AS attempts').group('user_id')

    # TODO
    # Panda loves Arel
    # but subqueries are so hard!
    # please make bear happy.
    User.contestant.find_by_sql(%Q{
      SELECT users.*, solved, attempts, elapsed
        FROM users INNER JOIN (#{ solutions.to_sql }) q1 ON q1.user_id = users.id
                   INNER JOIN (#{ attempts.to_sql }) q2 ON q2.user_id = users.id
       ORDER BY solved DESC, attempts, elapsed
       LIMIT #{ limit }
    })
  end
end
