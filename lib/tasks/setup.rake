require 'fileutils'
require 'securerandom'
require 'rainbow'

desc 'Setup project for development / deploy'
task :setup do

  section "Configuration Files" do
    database = File.join(Rails.root, 'config', 'database.yml')

    unless File.exists?(database)
      create_file(database, "Database config", true)
    else
      puts "Database config file already exists"
    end

    # TODO Editing of env variables
  end

  section "Database" do
    begin
      # Check if there are pending migrations
      silence { Rake::Task["db:abort_if_pending_migrations"].invoke }
      puts "Skip: Database already setup"
    rescue Exception
      silence do
        Rake::Task["db:create"].invoke
        Rake::Task["db:schema:load"].invoke
      end
      puts "Database setup"
    end
  end

  # Load the Rails Env now that the databases are setup
  Rake::Task["environment"].invoke

  section "Seed Data" do
    Rake::Task["db:seed"].invoke
  end

  puts # Empty Line
  puts "==== Setup Complete ====".color(:green)
  puts # Empty Line
end

private

def section(description)
  puts # Empty Line
  puts description.underline
  puts # Empty Line
  yield
end

def silence
  begin
    orig_stderr = $stderr.clone
    orig_stdout = $stdout.clone

    $stderr.reopen File.new('/dev/null', 'w')
    $stdout.reopen File.new('/dev/null', 'w')

    return_value = yield
  rescue Exception => e
    $stdout.reopen orig_stdout
    $stderr.reopen orig_stderr
    raise e
  ensure
    $stdout.reopen orig_stdout
    $stderr.reopen orig_stderr
  end

  return_value
end

