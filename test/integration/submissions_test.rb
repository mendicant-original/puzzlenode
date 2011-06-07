require 'test_helper'

class SubmissionsTest < ActionDispatch::IntegrationTest

  setup do
    @user = Factory(:user)
    @puzzle = Factory(:puzzle)
    @user.authorizations.create(:provider => "github", :uid => "12345")
  end

  test "show error when no file is submitted" do
    sign_user_in

    visit new_puzzle_submission_path(@puzzle)
    click_button "Submit my solution"

    assert_content "Please select a file to upload."
  end
end
