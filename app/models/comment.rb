class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :puzzle

  # Notify the other users who have solved this puzzle
  # when a new comment is made.
  def notify_comment_made
    notified_users = puzzle.solved_by.where(:notify_comment_made => true)

    CommentMailer.comment_made(self, notified_users).deliver
  end

end
