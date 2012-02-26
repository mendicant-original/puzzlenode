require 'fileutils'
require 'securerandom'

desc 'Setup project for development / deploy'
task :setup do

  section "Configuration Files" do

    database       = File.join(Rails.root, 'config', 'database.yml')
    secret_token   = File.join(Rails.root, 'config', 'initializers', 'secret_token.rb')
    omniauth       = File.join(Rails.root, 'config', 'initializers', 'omniauth.rb')
    mail_settings  = File.join(Rails.root, 'config', 'initializers', 'mail_settings.rb')

    unless File.exists?(database)
      create_file(database, "Database config", true)
    else
      puts "Database config file already exists"
    end

    unless File.exists?(secret_token)
      secret   = SecureRandom.hex(64)
      template = ERB.new(File.read(secret_token + '.example'))

      File.open(secret_token, 'w') {|f| f.write(template.result(binding)) }
      puts "Secret Token Generated"
    else
      puts "Secret Token file already exists"
    end

    unless File.exists?(omniauth)
      create_file(omniauth, "Omniauth config")
    else
      "Omniauth config file already exists"
    end

    unless File.exists?(mail_settings)
      create_file(mail_settings, "Mail_settings config")
    else
      "Mail_settings config file already exists"
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

def create_file(file, name, requires_edit=false)
  FileUtils.cp(file + '.example', file)
  puts "#{name} file created".color(:green)

  if requires_edit
    puts "Update #{file} and run `bundle exec rake setup` to continue".color(:red)
    system(ENV['EDITOR'], file) unless ENV['EDITOR'].blank?
    exit
  end
end
