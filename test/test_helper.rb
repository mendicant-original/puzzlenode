ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'capybara/rails'
require 'support/integration'
require 'support/mini_contest'
require 'test_notifier/runner/minitest'

TestNotifier.silence_no_notifier_warning = true
Turn.config.natural                      = true

class ActiveSupport::TestCase
  def build_puzzle
    test_tempfile = Tempfile.new("puzzle_sample")
    test_tempfile << "Sample Text"
    test_tempfile.rewind

    FactoryGirl.create(:puzzle, :file => test_tempfile)
  end

  def create_submission(puzzle, user, correct)
    Submission.create(
      :user   => user,
      :puzzle => puzzle,
      :file   => Tempfile.new('solution')
    ).update_attribute(:correct, correct)
  end

  def cleanup_attachment(attachment)
    FileUtils.rm_rf(attachment.file.path)
  end

end

class ActionDispatch::IntegrationTest
  include Capybara::DSL
  include Support::Integration

  setup do
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:github] = {
      'provider'  => "github",
      'uid'       => '12345',
      'user_info' => { 'nickname' => 'PN User' }
    }
  end
  teardown { Capybara.reset_sessions! }
end
