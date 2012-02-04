require 'test_helper'

class PuzzleTest < ActiveSupport::TestCase
  test "must require a slug" do
    puzzle = Factory.build(:puzzle, :slug => nil)
    refute puzzle.valid?
  end

  test "the slug must be unique" do
    puzzle       = Factory(:puzzle, :slug => "cheese-sticks")
    other_puzzle = Factory.build(:puzzle, :slug => "cheese-sticks")
    refute other_puzzle.valid?
  end

  test "must be able to create a fingerprint for a file" do
    tempfile = Tempfile.new("puzzle_sample")
    tempfile << "Sample Text\n"
    tempfile.rewind

    expected_fingerprint = Digest::SHA1.hexdigest(tempfile.read)
    tempfile.rewind

    puzzle = Factory(:puzzle, :file => tempfile)

    assert_equal expected_fingerprint, puzzle.fingerprint
  end

  test "must consider files with matching fingerprints valid" do
    seed_tempfile = Tempfile.new("puzzle_sample")
    seed_tempfile << "sample text"
    seed_tempfile.rewind

    test_tempfile = Tempfile.new("puzzle_sample2")
    test_tempfile << "sample text"
    test_tempfile.rewind

    puzzle = Factory(:puzzle, :file => seed_tempfile)

    assert puzzle.valid_solution?(test_tempfile)
  end

  test "must consider files with non-matching fingerprints invalid" do
    seed_tempfile = Tempfile.new("puzzle_sample")
    seed_tempfile << "sample text"
    seed_tempfile.rewind

    test_tempfile = Tempfile.new("puzzle_sample2")
    test_tempfile << "wow, this totally doesn't match, buddy"
    test_tempfile.rewind

    puzzle = Factory(:puzzle, :file => seed_tempfile)

    assert !puzzle.valid_solution?(test_tempfile)
  end

  test "must consider files with crlf and lf line endings as the same" do
    tempfile1 = Tempfile.new("puzzle_sample")
    tempfile1 << "First line\nSecond line"
    tempfile1.rewind

    tempfile2 = Tempfile.new("puzzle_sample2")
    tempfile2 << "First line\r\nSecond line"
    tempfile2.rewind

    puzzle = Factory(:puzzle, :file => tempfile1)
    assert puzzle.valid_solution?(tempfile2)

    puzzle = Factory(:puzzle, :file => tempfile2)
    assert puzzle.valid_solution?(tempfile1)    
  end

  test "must consider files with and without trailing LF as the same" do
    tempfile1 = Tempfile.new("puzzle_sample")
    tempfile1 << "First line\n"
    tempfile1.rewind

    tempfile2 = Tempfile.new("puzzle_sample2")
    tempfile2 << "First line"
    tempfile2.rewind

    puzzle = Factory(:puzzle, :file => tempfile1)
    assert puzzle.valid_solution?(tempfile2)

    puzzle = Factory(:puzzle, :file => tempfile2)
    assert puzzle.valid_solution?(tempfile1)    
  end

  test "must be taggable" do
    puzzle = Factory(:puzzle, :tag_list => "Game, Graphics")

    assert_equal 2, puzzle.tags.count
  end

  test "must generate a filename with markdown extension from its name attribute" do
    puzzle = Factory(:puzzle, :name => "Six Degrees of Separation")
    assert_equal puzzle.file_name, "six_degrees_of_separation.markdown"
  end

  test "must generate a filepath" do
    puzzle = Factory(:puzzle, :name => "Six Degrees of Separation")
    assert_equal puzzle.file_path, File.join(Rails.root, 'public', 'puzzles',
                                             puzzle.id.to_s, puzzle.file_name)
  end
end
