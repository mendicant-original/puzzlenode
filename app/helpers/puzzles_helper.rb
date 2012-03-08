module PuzzlesHelper

  def show_solution_button?(user, puzzle)
    (user && user.draft_access?) || !puzzle.answered_correctly?(user)
  end

  def file_link(name, path)
    link_to image_tag("icons/file_small.png") + name, path
  end

end
