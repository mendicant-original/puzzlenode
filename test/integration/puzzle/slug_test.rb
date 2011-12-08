require 'test_helper'

class Puzzle
  class SlugTest < ActionDispatch::IntegrationTest
    test "access puzzle by slug" do
      puzzle = Factory(:puzzle,
                       :name => "A regular puzzle",
                       :slug => "a-regular-puzzle")

      visit puzzle_path("a-regular-puzzle")

      assert_content "A regular puzzle"
    end

    test "raises a routing error when the slug does not exist" do
      assert_raise ActiveRecord::RecordNotFound do
        visit puzzle_path("this-thing-does-not-exist")
      end
    end
  end
end
