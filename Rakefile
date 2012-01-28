# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)
require 'rake'

Puzzlenode::Application.load_tasks

task :generate_slugs => :environment do
  Puzzle.all.each do |puzzle|
    puzzle.slug = Slugger.generate(puzzle.name)
    puzzle.save!
  end
end
