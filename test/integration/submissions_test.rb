require 'test_helper'

class SubmissionsTest < ActionDispatch::IntegrationTest

  setup do
    @user = FactoryGirl.create(:user)
    @puzzle = FactoryGirl.create(:puzzle)
    @user.authorizations.create(:provider => "github", :uid => "12345")
  end

  test "show error when no file is submitted" do
    sign_user_in

    visit new_puzzle_submission_path(@puzzle)
    click_button "Submit my solution"

    assert_content "File can't be blank"
  end

  test "there are no errors when a file is submitted" do
    sign_user_in

    visit new_puzzle_submission_path(@puzzle)

    solution_file = Tempfile.new("solution.txt")
    solution_file.write "SOLUTION!"
    solution_file.close

    attach_file "submission_file", solution_file.path
    click_button "Submit my solution"

    submission = @user.submissions.order("created_at DESC").first

    assert_current_path user_submission_path(@user, submission)
  end
end
