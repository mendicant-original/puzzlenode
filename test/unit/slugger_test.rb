require 'test_helper'

class PuzzleTest < ActiveSupport::TestCase

  test "must remove square brackets around integers at the beginning of string" do
    assert_equal "1-a-puzzle", Slugger.generate("[1] A puzzle")
  end

end
