require 'bundler/capistrano'

set :application, "puzzlenode"
set :repository,  "git://github.com/mendicant-original/puzzlenode.git"

set :scm, :git
set :deploy_to, "/var/rapp/#{application}"

set :user, "git"
set :use_sudo, false

set :deploy_via, :remote_cache
set :rake, "bundle exec rake"

set :branch, "master"
server "puzzlenode.com", :app, :web, :db, :primary => true

namespace :deploy do
  task :restart, :roles => :app do
    run "touch #{current_path}/tmp/restart.txt"
  end
end

after 'deploy:update_code' do
  {"database.yml"    => "config/database.yml",
   "omniauth.rb"     => "config/initializers/omniauth.rb",
   "secret_token.rb" => "config/initializers/secret_token.rb",
   "setup_mail.rb"   => "config/initializers/setup_mail.rb",
   "attachments"     => "public/attachments"}.
  each do |from, to|
    run "ln -nfs #{shared_path}/#{from} #{release_path}/#{to}"
  end
end

after "deploy", "deploy:migrate"
after "deploy", 'deploy:cleanup'

load 'deploy/assets'
