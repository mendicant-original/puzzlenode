module LeaderboardHelper
  def ranking_detail(user)
    "#{ pluralize user.solved, 'correct solution' } in #{ pluralize user.attempts, 'attempt' }"
  end
end
