require 'test_helper'

class Puzzle
  class NoticeTest < ActionDispatch::IntegrationTest

    setup do
      @user = Factory(:user, :name => "Normal User")
      @user.authorizations.create(:provider => "github", :uid => "12345")
      @puzzle = Factory(:puzzle)
    end

    test "notice isn't displayed when not present" do
      sign_user_in

      visit puzzle_path(@puzzle)

      assert page.has_no_selector?("div#notice"),
        "Notice present when shouldn't be!"
    end

    test "notice is displayed when present" do
      @puzzle.update_attribute(:notice, "You have been notified!")

      sign_user_in

      visit puzzle_path(@puzzle)

      assert page.has_selector?("div#notice"), "Notice missing!"
      assert_content @puzzle.notice
    end
  end
end
