source 'http://rubygems.org'

########
# Core #
########

gem 'rails',    '~> 3.2.11'
gem 'omniauth-github', '~> 1.0.1'
gem 'rake',     '~> 0.9.2'
gem 'json',     '~> 1.7.7'
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
gem 'redcarpet', '2.1'
gem 'will_paginate', '~> 3.0'
gem 'cocoon'
gem 'jquery-rails'
gem 'md_preview'
gem 'md_emoji'

###############
# Maintenance #
###############

gem 'capistrano'
gem 'exception_notification'

group :assets do
  gem 'sass-rails',   '~> 3.2.0'
  gem 'coffee-rails', '~> 3.2.0'
  gem 'uglifier'
  gem 'compass-rails'
end

group 'test' do
  gem 'sqlite3'
  gem 'capybara',  '~> 1.1.1'
  gem 'factory_girl_rails', '4.1.0'
  gem 'colorific', '~> 1.0.0'
  gem 'test_notifier', '~> 1.0.0'
end

group :development do
  gem 'rainbow'
end

group :production do
  gem 'therubyracer'
end
