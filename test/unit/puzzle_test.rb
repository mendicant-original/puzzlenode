require 'test_helper'

class PuzzleTest < ActiveSupport::TestCase
  test "Puzzle#file= should write a SHA1 fingerprint" do
    tempfile = Tempfile.new("puzzle_sample")
    tempfile << "Sample Text"
    tempfile.rewind

    expected_fingerprint = Digest::SHA1.hexdigest(tempfile.read)
    tempfile.rewind

    puzzle = Puzzle.new(:file => tempfile)

    assert_equal expected_fingerprint, puzzle.fingerprint
  end

  test "puzzle#valid_solution? should return true if contents match" do
    seed_tempfile = Tempfile.new("puzzle_sample")
    seed_tempfile << "sample text"
    seed_tempfile.rewind

    test_tempfile = Tempfile.new("puzzle_sample2")
    test_tempfile << "sample text"
    test_tempfile.rewind

    puzzle = Puzzle.new(:file => seed_tempfile)

    assert puzzle.valid_solution?(test_tempfile)
  end 

  test "puzzle#valid_solution? should return false if contents don't match" do
    seed_tempfile = Tempfile.new("puzzle_sample")
    seed_tempfile << "sample text"
    seed_tempfile.rewind

    test_tempfile = Tempfile.new("puzzle_sample2")
    test_tempfile << "wow, this totally doesn't match, buddy"
    test_tempfile.rewind

    puzzle = Puzzle.new(:file => seed_tempfile)

    assert !puzzle.valid_solution?(test_tempfile)
  end 

end
