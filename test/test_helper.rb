ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.(yml|csv) for all tests in alphabetical order.
  #
  # Note: You'll currently still have to declare fixtures explicitly in integration tests
  # -- they do not yet inherit this setting
  fixtures :all

  # Add more helper methods to be used by all tests here...
  
  def build_puzzle
    test_tempfile = Tempfile.new("puzzle_sample")
    test_tempfile << "Sample Text"
    test_tempfile.rewind

    return Puzzle.create(:file => test_tempfile)
  end
  
  def cleanup_attachment(attachment)
    FileUtils.rm_rf(attachment.directory)
  end
  
end
