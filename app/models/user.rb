class User < ActiveRecord::Base
  has_many :authorizations, :dependent => :destroy
  has_many :announcements,  :dependent => :destroy, :foreign_key => "author_id"
  has_many :submissions,    :dependent => :destroy

  attr_protected :admin, :draft_access

  scope :admin, where(:admin => true)
  scope :eligible_for_display, where(:admin => false, :draft_access => false)

  def self.create_from_hash!(hash)
    create(:name     => hash['info']['name'],
           :nickname => hash['info']['nickname'],
           :email    => hash['info']['email'])
  end

  def name
    read_attribute(:name) || nickname || "Anonymous ##{id}"
  end

  def real_name
    read_attribute(:name)
  end

  def refresh_names(hash)
    return if nickname && email

    update_attributes(:name     => hash['info']['name'],
                      :nickname => hash['info']['nickname'],
                      :email    => hash['info']['email'])
  end

  def solution_for(puzzle)
    return if puzzle.nil?
    submissions.where(:puzzle_id => puzzle.id, :correct => true).first
  end

  def local_leaderboard(offset=5)
    return unless leaderboard_position

    rank_offset = leaderboard_position - offset - 1
    User.leaderboard(10, rank_offset)
  end

  def leaderboard_position
    rank = Submission.find_by_sql("SELECT id, rank
      FROM (#{User.leaderboard(0,0).to_sql}) as leaderboard WHERE id = #{id}")
    rank.first.rank.to_i unless rank.empty?
  end

  def self.leaderboard(limit=10, offset=0)
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

    leaderboard = User.select(%{users.*, solved, latest_solution,
      rank() OVER (ORDER BY solved DESC, latest_solution)}).
      joins("INNER JOIN (#{solutions.to_sql}) q1 on q1.user_id = users.id").
      order("solved DESC", "latest_solution").
      eligible_for_display

    leaderboard = leaderboard.offset(offset) if offset > 0
    leaderboard = leaderboard.limit(limit)   if limit  > 0

    leaderboard
  end
end
