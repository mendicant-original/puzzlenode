class CommentMailer < ActionMailer::Base
  default :from => "puzzlenodetest@gmail.com"

  def comment_made(comment, users)
    @comment = comment
    @puzzle = comment.puzzle

    subject = "[PuzzleNode] #{@comment.user.nickname} commented on #{@puzzle.name}"

    users.each do |user|
      @user = user
      to = user.email
      mail(:to => to, :subject => subject)
    end
  end
end
