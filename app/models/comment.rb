class Comment < ActiveRecord::Base
  after_create :notify_comment_made

  belongs_to :user
  belongs_to :puzzle

  # Notify the other users who have solved this puzzle
  # when a new comment is made.
  def notify_comment_made
    return true # Temporarily disable this feature

    users   = puzzle.solved_by.where(:notify_comment_made => true)
    users  += User.where(:admin => true, :notify_comment_made => true)
    users  -= [ user ]

    emails  = users.map(&:email).compact.uniq

    emails.each_slice(25) do |e|
      CommentMailer.comment_made(self, e).deliver
    end
  end
end
