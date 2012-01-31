class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :puzzle

  # Notify the other users who have solved this puzzle
  # when a new comment is made.
  def notify_comment_made
    notified_users = []

    puzzle.solved_by.each do |user|
      notified_users << user if user.notify_comment_made
    end

    CommentMailer.comment_made(self, notified_users).deliver
  end

end
