class CommentMailer < ActionMailer::Base
  default :from => "puzzlenode+noreply@gmail.com"

  def comment_made(comment, emails)
    @comment = comment
    @puzzle  = comment.puzzle

    subject = "[PuzzleNode] #{@comment.user.nickname} commented on #{@puzzle.name}"

    to  = "<PuzzleNode> puzzlenode+noreply@gmail.com"
    mail(:to => to, :bcc => emails, :subject => subject)
  end
end
