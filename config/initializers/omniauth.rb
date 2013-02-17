Rails.application.config.middleware.use OmniAuth::Builder do
  provider :developer, fields: [:name, :email, :nickname] unless Rails.env.production?
  provider :github, ENV['GITHUB_CONSUMER_KEY'], ENV['GITHUB_CONSUMER_SECRET']
end
