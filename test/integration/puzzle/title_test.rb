require 'test_helper'

class Puzzle
  class TitleTest < ActionDispatch::IntegrationTest

    setup do
      @puzzle = FactoryGirl.create(:puzzle, :name => "Crazy Ups and Downs")
    end

    test "title is set" do
      visit puzzle_path(@puzzle)

      assert_title "#{@puzzle.name} - PuzzleNode"
    end
  end
end
