module UsersHelper
  def gravatar_image(user, size=80)
    key = Digest::MD5.hexdigest(user.email.to_s.downcase)
    image_tag "http://www.gravatar.com/avatar/#{ key }?d=retro&size=#{ size }"
  end

  def github_url(user)
    "http://github.com/#{ user.nickname }"
  end
end
