source 'http://rubygems.org'

########
# Core #
########

gem 'rails',    '~> 3.1.1'
gem 'omniauth-github', '~> 1.0.1'
gem 'rake',     '~> 0.9.2'

########
# Data #
########

gem 'pg'
gem 'acts-as-taggable-on'
gem 'jquery-rails'
gem 'faker', :require => false

################
# Mail #
################

gem 'delayed_mailhopper'
gem 'delayed_job_active_record'
gem 'daemons', :require => false

################
# Presentation #
################

gem 'haml'
gem 'sass'
gem 'redcarpet', '~> 2.0.0b3'
gem 'will_paginate', '~> 3.0'
gem 'cocoon'
gem 'jquery-rails'

###############
# Maintenance #
###############

gem 'capistrano'
gem 'exception_notification'

group :assets do
  gem 'sass-rails',   '~> 3.1.0'
  gem 'coffee-rails', '~> 3.1.0'
  gem 'uglifier'
  gem 'compass',      '~> 0.12.alpha'
end

group 'test' do
  gem 'capybara',  '~> 1.1.1'
  gem 'factory_girl_rails'
  gem 'colorific', '~> 1.0.0'
  gem 'test_notifier', '~> 1.0.0'
end

group :development do
  gem 'rainbow'
end

group :production do
  gem 'therubyracer'
end
