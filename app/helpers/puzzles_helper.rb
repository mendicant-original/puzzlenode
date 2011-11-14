module PuzzlesHelper

  def show_solution_button?(user, puzzle)
    (user && user.draft_access?) || !puzzle.answered_correctly?(user)
  end

end
