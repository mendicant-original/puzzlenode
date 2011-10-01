require 'bundler/capistrano'

set :application, "puzzlenode"
set :repository,  "git://github.com/rmu/puzzlenode.git"

set :scm, :git
set :deploy_to, "/var/rapp/_#{application}"

set :user, "git"
set :use_sudo, false

set :deploy_via, :remote_cache

set :branch, "rails31" #master
server "rubymendicant.com", :app, :web, :db, :primary => true

namespace :deploy do
  task :restart, :roles => :app do
    run "touch #{current_path}/tmp/restart.txt"
  end
end

after 'deploy:update_code' do
  {"database.yml"    => "config/database.yml",
   "omniauth.yml"    => "config/omniauth.yml",
   "secret_token.rb" => "config/initializers/secret_token.rb"}.
  each do |from, to|
    run "ln -nfs #{shared_path}/#{from} #{release_path}/#{to}"
  end
end

after "deploy", "deploy:migrate"
load 'deploy/assets'