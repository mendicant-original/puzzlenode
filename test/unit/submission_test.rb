require 'test_helper'

class SubmissionTest < ActiveSupport::TestCase
  test "must be able to detect when submission is correct" do
    pending
  end

  test "no more submissions should be allowed once a correct one is submitted" do
    user   = Factory(:user)
    file   = Tempfile.new("test_tempfile")
    puzzle = Factory(:puzzle, :file => file)

    user.submissions.create(:puzzle => puzzle, :file => file)
    second_submission = user.submissions.create(:puzzle => puzzle, :file => file)

    assert second_submission.new_record?, "Record saved when it shouldn't"
  end
end
