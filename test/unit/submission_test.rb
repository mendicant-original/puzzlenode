require 'test_helper'

class SubmissionTest < ActiveSupport::TestCase
  def setup
    @user   = FactoryGirl.create(:user)
    @file   = Tempfile.new("test_tempfile")
    @file.write "SOLUTION!"
    @file.rewind

    @puzzle = FactoryGirl.create(:puzzle, :file => @file)
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

  test "for users with draft access multiple correct submissions are possible" do
    @user.update_attribute(:draft_access, true)
    second_submission = @user.submissions.create(:puzzle => @puzzle, :file => @file)

    assert !second_submission.new_record?, "Record not saved when it should have been"
  end
end
