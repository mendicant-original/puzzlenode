require 'test_helper'

class Puzzle
  class TagsTest < ActionDispatch::IntegrationTest

    setup do
      @user = FactoryGirl.create(:user, :name => "Normal User")
      @user.authorizations.create(:provider => "github", :uid => "12345")
      @puzzle = FactoryGirl.create(:puzzle, :name => "Puzzle Name", :tag_list => "Game, Graphics")
    end

    test "list puzzle by tag" do
      invisible_puzzle = FactoryGirl.create(:puzzle, :name => "Invisible Puzzle", :tag_list => "Math, TDD")

      sign_user_in

      visit tag_path("Game")

      assert_content @puzzle.name
      assert_no_content invisible_puzzle.name
    end
  end
end
