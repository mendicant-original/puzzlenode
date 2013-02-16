Rails.application.config.middleware.use OmniAuth::Builder do
  provider :developer, fields: [:name, :email, :nickname] unless Rails.env.production?
  provider :github, ENV['github_consumer_key'], ENV['github_consumer_secret']
end
