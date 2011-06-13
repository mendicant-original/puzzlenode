require 'test_helper'

class Puzzle
  class CommentsTest < ActionDispatch::IntegrationTest
    def create_correct_submission(user, puzzle)
      submission = user.submissions.create do |submission|
        submission.puzzle = puzzle
        submission.file = Tempfile.new("solution")
        submission.correct = true
      end
      submission.update_attribute(:correct, true)
    end

    setup do
      @user = Factory(:user, :name => "Normal User")
      @user.authorizations.create(:provider => "github", :uid => "12345")
      @admin = Factory(:user, :name => "Admin User", :admin => true)
      @draft_access = Factory(:user, :name => "Draft Access User", :draft_access => true)
      @puzzle = Factory(:puzzle)
    end

    test "only show normal user in the solved by list" do
      create_correct_submission @user, @puzzle
      create_correct_submission @admin, @puzzle
      create_correct_submission @draft_access, @puzzle

      sign_user_in

      visit puzzle_comments_path(@puzzle)

      assert_content "Normal User"
      assert_no_content "Admin User"
      assert_no_content "Draft Access User"
    end
  end
end
