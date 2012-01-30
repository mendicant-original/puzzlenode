class CommentMailer < ActionMailer::Base
  default from: "puzzlenodetest@gmail.com"

  def comment_made(subject, to, body)
    @body = body
    mail(:to => to, :subject => subject)
  end
end
