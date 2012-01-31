class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :puzzle

  # Notify the other users who have solved this puzzle
  # when a new comment is made.
  def notify_comment_made
    notified_users = []

    notified_users = puzzle.solved_by.inject([]) do |accum, user|
      accum << user if user.notify_comment_made
    end

    CommentMailer.delay.comment_made(self, notified_users)
  end

end
