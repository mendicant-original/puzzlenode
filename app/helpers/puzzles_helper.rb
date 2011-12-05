module PuzzlesHelper

  def show_solution_button?(user, puzzle)
    (user && user.draft_access?) || !puzzle.answered_correctly?(user)
  end

  def file_link(file)
    link_to image_tag("icons/file_small.png") + file.file_name,
            file.public_path,
            :target => "_blank"
  end

end
