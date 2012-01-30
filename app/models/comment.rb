class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :puzzle

  # Notify the other users who have solved this puzzle
  # when a new comment is made.
  def notify_others
    puzzle = self.puzzle
    user = self.user

    email_subject = "PuzzleNode new comment posted"
    email_body = "User #{user.nickname} has just posted a comment " +
      "to puzzle '#{puzzle.name}': \n\n" + body

    puts "email_subject: #{email_subject}"
    puts "email_body: #{email_body}"

    solved_users = puzzle.solved_by

    solved_users.each do |user|
      puts "solved user email: #{user.email}"
      if user.notify_comment_made
        puts "notify user: #{user.nickname}"
        to = user.email
        CommentMailer.delay.comment_made(email_subject, to, email_body)
      end
    end
  end

end
