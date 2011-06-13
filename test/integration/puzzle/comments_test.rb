require 'test_helper'

class Puzzle
  class CommentsTest < ActionDispatch::IntegrationTest

    setup do
      @user = Factory(:user, :name => "Normal User")
      @user.authorizations.create(:provider => "github", :uid => "12345")
      @admin = Factory(:user, :name => "Admin User", :admin => true)
      @draft_access = Factory(:user, :name => "Draft Access User", :draft_access => true)
      @puzzle = Factory(:puzzle)
    end

    test "only show normal user in the solved by list" do
      create_submission @puzzle, @user, true
      create_submission @puzzle, @admin, true
      create_submission @puzzle, @draft_access, true

      sign_user_in

      visit puzzle_comments_path(@puzzle)

      assert_content "Normal User"
      assert_no_content "Admin User"
      assert_no_content "Draft Access User"
    end
  end
end
