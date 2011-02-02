require 'test_helper'

class PuzzleTest < ActiveSupport::TestCase
  test "must be able to create a fingerprint for a file" do
    tempfile = Tempfile.new("puzzle_sample")
    tempfile << "Sample Text"
    tempfile.rewind

    expected_fingerprint = Digest::SHA1.hexdigest(tempfile.read)
    tempfile.rewind

    puzzle = Puzzle.new(:file => tempfile)

    assert_equal expected_fingerprint, puzzle.fingerprint
  end

  test "must consider files with matching fingerprints valid" do
    seed_tempfile = Tempfile.new("puzzle_sample")
    seed_tempfile << "sample text"
    seed_tempfile.rewind

    test_tempfile = Tempfile.new("puzzle_sample2")
    test_tempfile << "sample text"
    test_tempfile.rewind

    puzzle = Puzzle.new(:file => seed_tempfile)

    assert puzzle.valid_solution?(test_tempfile)
  end 

  test "must consider files with non-matching fingerprints invalid" do
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
