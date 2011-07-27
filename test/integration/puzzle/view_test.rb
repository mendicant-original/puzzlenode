require 'test_helper'

class Puzzle
  class ViewTest < ActionDispatch::IntegrationTest

    setup do
      @puzzle = Factory(:puzzle)
    end

    test "title is set" do
      visit puzzle_path(@puzzle)
      assert_content("Puzzle Puzzle")
    end
  end
end
