class User < ActiveRecord::Base
  has_many :authorizations, :dependent => :destroy
  has_many :announcements,  :dependent => :destroy, :foreign_key => "author_id"
  has_many :submissions,    :dependent => :destroy

  attr_protected :admin, :draft_access

  scope :admin, where(:admin => true)
  scope :eligible_for_display, where(:admin => false, :draft_access => false)

  def self.create_from_hash!(hash)
    create(:name     => hash['user_info']['name'],
           :nickname => hash['user_info']['nickname'],
           :email    => hash['user_info']['email'])
  end

  def name
    read_attribute(:name) || nickname || "Anonymous ##{id}"
  end

  def real_name
    read_attribute(:name)
  end

  def refresh_names(hash)
    return if nickname && email

    update_attributes(:name     => hash['user_info']['name'],
                      :nickname => hash['user_info']['nickname'],
                      :email    => hash['user_info']['email'])
  end

  def solution_for(puzzle)
    return if puzzle.nil?
    submissions.where(:puzzle_id => puzzle.id, :correct => true).first
  end

  def local_leaderboard(offset=5)
    leaderboard_query = "SELECT user_id, rank FROM
        (SELECT user_id, max(created_at) as latest_solution, count(*) AS solved,
        rank() OVER (order by count(*) desc, max(created_at)) as rank 
        FROM submissions GROUP BY user_id) as leaderboard"
    my_rank = Submission.find_by_sql("
      #{leaderboard_query} WHERE leaderboard.user_id = #{id.to_s}")
  
    rank = my_rank.first.rank.to_i

    Submission.find_by_sql("#{leaderboard_query} 
      WHERE leaderboard.rank BETWEEN #{rank - offset + 1} AND #{rank + offset}")
  end

  def leaderboard_position(limit=10)
    position = User.leaderboard(limit).index(self)
    position + 1 if position
  end

  def self.leaderboard(limit=10)
    # For each user, we need a count of correct submissions, along with
    # the date of the most recent correct submission.

    solutions = Submission.correct.
      select('user_id, MAX(created_at) AS latest_solution, COUNT(*) AS solved').
      group('user_id')

    # We want to sort results by:
    #   1) highest number of correct scores
    #   2) earliest creation date of the *last* correct submission
    #
    # This inner join is a bit fugly, but it allows us to gather all
    # the data and use it both for sorting and for displaying with
    # one database query.

    User.select("users.*, solved, latest_solution").
      joins("INNER JOIN (#{solutions.to_sql}) q1 on q1.user_id = users.id").
      order("solved DESC", "latest_solution").
      limit(limit).eligible_for_display
  end
end
