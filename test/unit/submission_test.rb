require 'test_helper'

class SubmissionTest < ActiveSupport::TestCase
  def setup
    @user   = Factory(:user)
    @file   = Tempfile.new("test_tempfile")
    @file.write "SOLUTION!"
    @file.rewind

    @puzzle = Factory(:puzzle, :file => @file)
    @file.rewind

    @submission = @user.submissions.create(:puzzle => @puzzle, :file => @file)
    @file.rewind
  end

  def teardown
    @file.close
    @file.unlink
  end

  test "must be able to detect when submission is correct" do
    assert @submission.correct, "Submission is not correct but it should be!"
  end

  test "no more submissions should be allowed once a correct one is submitted" do
    second_submission = @user.submissions.create(:puzzle => @puzzle, :file => @file)

    assert second_submission.new_record?, "Record saved when it shouldn't"
  end
end
