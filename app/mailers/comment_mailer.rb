class CommentMailer < ActionMailer::Base
  default from: "puzzlenodetest@gmail.com"

  def comment_made(subject, to, body)
    puts "send email: "
    puts "subject: #{subject}"
    puts "to: #{to}"
    puts "body: #{body}"
    @body = body
    mail(:to => to, :subject => subject)
  end
end
