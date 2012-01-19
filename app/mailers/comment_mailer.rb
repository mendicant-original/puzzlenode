class CommentMailer < ActionMailer::Base
  default from: "puzzlenodetest@gmail.com"

  def comment_made(subject, to, body)
    @subject = subject
    @body = body
    mail(:to => to, :subject => subject)
  end
end
