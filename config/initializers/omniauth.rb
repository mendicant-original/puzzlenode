keys = YAML.load_file("#{Rails.root}/config/omniauth.yml")

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, keys['twitter']['key'], keys["twitter"]['secret']
  provider :github,  keys['github']['client'], keys['github']['secret']
end