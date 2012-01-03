class CommentMailer < ActionMailer::Base
  default from: "puzzlenodetest@gmail.com"

  def welcome_email(user)
    @user = user
    @user.name = "Jingjing Duan"
    @user.login = "jduan"
    @url = "http://example.com/login"
    mail(:to => "duanjingjing@gmail.com", :subject => "Welcome to my site")
  end
end
