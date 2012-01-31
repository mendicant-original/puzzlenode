class Comment < ActiveRecord::Base
  after_create :notify_comment_made

  belongs_to :user
  belongs_to :puzzle

  # Notify the other users who have solved this puzzle
  # when a new comment is made.
  def notify_comment_made
    users  = puzzle.solved_by.where(:notify_comment_made => true) - [user]
    emails = users.map(&:email).compact

    emails.each_slice(25) do |e|
      CommentMailer.comment_made(self, e).deliver
    end
  end
end
