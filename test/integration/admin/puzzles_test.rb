require 'test_helper'

module Admin
  class PuzzlesTest < ActionDispatch::IntegrationTest
    
    setup do
      @admin_user = Factory(:user, :admin => true)
      @admin_user.authorizations.create(:provider => "github", :uid => "12345")
    end
    
    teardown do
      Capybara.use_default_driver
    end
    
    test "Admin users can create new puzzles" do
      sign_user_in
      
      visit new_admin_puzzle_path
      
      fill_in "Name",              :with => "Test Puzzle"
      fill_in "Short description", :with => "Test Puzzle Short Desc"
      fill_in "Description",       :with => "Test Puzzle Desc"
      
      click_button "Create Puzzle"
      
      assert_current_path admin_puzzles_path
    end
  end
end
