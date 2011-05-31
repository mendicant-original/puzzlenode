class User < ActiveRecord::Base
  has_many :authorizations, :dependent => :destroy
  has_many :announcements,  :dependent => :destroy, :foreign_key => "author_id"
  has_many :submissions,    :dependent => :destroy

  attr_protected :admin
  
  def self.create_from_hash!(hash)    
    create(:name     => hash['user_info']['name'], 
           :nickname => hash['user_info']['nickname'],
           :email    => hash['user_info']['email'])
  end

  def name
    read_attribute(:name) || nickname || "Anonymous ##{id}"
  end

  def refresh_names(hash)
    return if nickname

    update_attributes(:name     => hash['user_info']['name'],
                      :nickname => hash['user_info']['nickname'],
                      :email    => hash['user_info']['email'])
  end
  
  def solution_for(puzzle)
    return if puzzle.nil?
    submissions.where(:puzzle_id => puzzle.id, :correct => true).first
  end

  def self.leaderboard(limit=10)
    # For each user, we need a count of correct submissions, along with
    # the date of the most recent correct submission.
    # We also need a count of all submissions correct or not.
    solutions = Submission.correct.select('user_id, MAX(created_at) AS latest_solution, COUNT(*) AS solved').group('user_id')
    attempts  = Submission.select('user_id, COUNT(*) AS attempts').group('user_id')

    # We want to sort results by:
    #   1) highest number of correct scores
    #   2) lowest number of attempts
    #   3) earliest creation date of the *last* correct submission
    #
    # This inner join is a bit fugly, but it allows us to gather all
    # the data and use it both for sorting and for displaying with
    # one database query.
    #
    # TODO
    # Panda loves Arel
    # but subqueries are so hard!
    # please make bear happy.
    User.find_by_sql(%Q{
      SELECT users.*, solved, attempts, latest_solution
        FROM users INNER JOIN (#{ solutions.to_sql }) q1 ON q1.user_id = users.id
                   INNER JOIN (#{ attempts.to_sql  }) q2 ON q2.user_id = users.id
       ORDER BY solved DESC, attempts, latest_solution
       LIMIT #{ limit }
    })
  end
end
