class CommentMailer < ActionMailer::Base
  default :from => "puzzlenodetest@gmail.com"

  def comment_made(subject, to, body)
    mail(:to => to, :subject => subject) do |format|
      format.text {render :text => body}
    end
  end
end
