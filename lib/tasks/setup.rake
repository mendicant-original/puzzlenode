require 'fileutils'
require 'highline'

HighLine.colorize_strings

desc 'runs the tasks necessary to setup PuzzleNode'
task :setup do

  section "Configuration Files" do

    database_file     = File.join(Rails.root, 'config', 'database.yml')
    omniauth_file     = File.join(Rails.root, 'config', 'omniauth.yml')
    secret_token_file = File.join(Rails.root, 'config', 'initializers', 'secret_token.rb')

    unless File.exists?(database_file)
      FileUtils.cp(database_file + '.example', database_file)
      puts "Database config file created".color(:green)
      puts "Update #{database_file} and run `bundle exec rake setup` to continue".color(:red)
      `$EDITOR #{database_file}`
      exit
    else
      puts "Database config file already exists"
    end

    unless File.exists?(omniauth_file)
      FileUtils.cp(omniauth_file + '.example', omniauth_file)
      puts "OmniAuth config file created".color(:green)
      puts "Update #{omniauth_file} and run `bundle exec rake setup` to continue".color(:red)
      `$EDITOR #{omniauth_file}`
      exit
    else
      puts "OmniAuth config file already exists"
    end

    unless File.exists?(secret_token_file)
      FileUtils.cp(secret_token_file + '.example', secret_token_file)
      token = `rake secret`

      text = File.read(secret_token_file)
      replace = text.gsub(/<RUN `rake secret` TO GENERATE A TOKEN>/, token.chomp)
      File.open(secret_token_file, "w") {|file| file.puts replace}

      puts "Secret Token file created".color(:green)
    else
      puts "Secret Token file already exists"
    end

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