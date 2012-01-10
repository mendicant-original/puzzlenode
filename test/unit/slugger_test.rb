require 'test_helper'

class PuzzleTest < ActiveSupport::TestCase

  test "must remove square brackets and pound symbol around a number" do
    assert_equal "1-a-puzzle", Slugger.generate("[#1] A puzzle")
  end

  test "only removes square bracket and pound number around a number at beginning of string" do
    assert_equal "a-puzzle-[#1]", Slugger.generate("A puzzle [#1] ")
  end

end
