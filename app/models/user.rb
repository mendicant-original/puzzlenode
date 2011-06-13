class User < ActiveRecord::Base
  has_many :authorizations, :dependent => :destroy
  has_many :announcements,  :dependent => :destroy, :foreign_key => "author_id"
  has_many :submissions,    :dependent => :destroy

  attr_protected :admin, :draft_access

  scope :admin, where(:admin => true)

  def self.create_from_hash!(hash)
    create(:name     => hash['user_info']['name'],
           :nickname => hash['user_info']['nickname'],
           :email    => hash['user_info']['email'])
  end

  def name
    read_attribute(:name) || nickname || "Anonymous ##{id}"
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

  def self.leaderboard(limit=10)
    # For each user, we need a count of correct submissions, along with
    # the date of the most recent correct submission.
    # We also need a count of all submissions correct or not.

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
    #
    # TODO
    # Panda loves Arel
    # but subqueries are so hard!
    # please make bear happy.
    User.select("users.*, solved, latest_solution").
      joins("INNER JOIN (#{solutions.to_sql}) q1 on q1.user_id = users.id").
      where(:admin => false).
      order("solved DESC", "latest_solution").
      limit(limit)
  end
end
