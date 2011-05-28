module UsersHelper
  def gravatar_image(user)
    key = Digest::MD5.hexdigest(user.email.to_s.downcase)
    image_tag "http://www.gravatar.com/avatar/#{ key }?d=retro"
  end

  def github_url(user)
    "http://github.com/#{ user.nickname }"
  end
end
