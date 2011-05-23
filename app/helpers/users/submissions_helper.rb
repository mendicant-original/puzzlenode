module Users::SubmissionsHelper
  
  # A special treat for BohConf ...
  #
  def baddy
    if @submission.correct
      link_to "You got 'em. Good job buddy!", "http://spotthebaddy.com", :target => "_blank"
    else
      link_to "The Baddy Got Away. Give it another try!", "http://spotthebaddy.com", :target => "_blank"
    end
  end
end
