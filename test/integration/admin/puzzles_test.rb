require 'test_helper'

module Admin
  class PuzzlesTest < ActionDispatch::IntegrationTest

    setup do
      @admin_user = Factory(:user, :admin => true)
      @admin_user.authorizations.create(:provider => "github", :uid => "12345")
    end

    test "Admin users can create new puzzles" do
      sign_user_in

      visit new_admin_puzzle_path

      fill_in "Name",              :with => "Test Puzzle"
      fill_in "Short description", :with => "Test Puzzle Short Desc"
      fill_in "Description",       :with => "Test Puzzle Desc"
      fill_in "Tags",              :with => "Test, Tag"

      click_button "Create Puzzle"

      assert_current_path puzzle_path(Puzzle.order("created_at DESC").first)

      assert_content "Test Puzzle"
    end

    test "Future puzzles aren't visible to basic users but admins can see them" do
      visible_puzzle = Factory(:puzzle, :name => "Visible Puzzle",
                                        :released_on => Date.yesterday)
      hidden_puzzle  = Factory(:puzzle, :name => "Hidden Puzzle",
                                        :released_on => Date.tomorrow)

      visit root_path

      assert_content "Visible Puzzle"
      assert_no_content "Hidden Puzzle"

      sign_user_in

      assert_content "Hidden Puzzle"
    end
  end
end
