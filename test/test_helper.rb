ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'capybara/rails'
require 'support/integration'

class ActiveSupport::TestCase
  #fixtures :all
  
  def build_puzzle
    test_tempfile = Tempfile.new("puzzle_sample")
    test_tempfile << "Sample Text"
    test_tempfile.rewind

    return Puzzle.create(
      :name              => "test", 
      :description       => "test",
      :short_description => "test", 
      :file              => test_tempfile
    )
  end
  
  def cleanup_attachment(attachment)
    FileUtils.rm_rf(attachment.directory)
  end
  
end

class ActionDispatch::IntegrationTest
  include Capybara
  include Support::Integration

  teardown { Capybara.reset_sessions! }
end

OmniAuth.config.test_mode = true
