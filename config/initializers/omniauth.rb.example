Rails.application.config.middleware.use OmniAuth::Builder do
  provider :developer, fields: [:name, :email, :nickname] unless Rails.env.production?
  provider :github, "consumer_key", "consumer_secret"
end