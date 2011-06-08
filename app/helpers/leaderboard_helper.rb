module LeaderboardHelper
  def ranking_detail(user)
    pluralize user.solved, 'correct solution'
  end
end
