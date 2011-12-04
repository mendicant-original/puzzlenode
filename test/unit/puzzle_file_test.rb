require 'test_helper'

class PuzzleFileTest < ActiveSupport::TestCase
  setup do
    @puzzle = Factory(:puzzle, :name => "Six Degrees of Separation")
    @puzzle_file = PuzzleFile.new(@puzzle)
  end

  test "must generate a filename with markdown extension from its name attribute" do
    assert_equal @puzzle_file.file_name, "six_degrees_of_separation.markdown"
  end

  test "must generate a filepath" do
    expected_path = File.join(Rails.root, 'public', 'puzzles', @puzzle.id.to_s, @puzzle_file.file_name)
    assert_equal @puzzle_file.file_path, expected_path
  end

  test "must save the file to the right location" do
    cleanup_puzzles

    assert !File.exists?(@puzzle_file.file_path)
    PuzzleFile.save(@puzzle)
    assert File.exists?(@puzzle_file.file_path)
  end

  test "must save the file with the correct contents" do
    @puzzle_file.save
    actual_file_contents = File.open(@puzzle_file.file_path).read
    assert_equal @puzzle_file.contents, actual_file_contents
  end

  test "must delete the file" do
    @puzzle_file.save
    assert File.exists?(@puzzle_file.file_path), "File does not exist before deleting"
    @puzzle_file.delete
    assert !File.exists?(@puzzle_file.file_path), "File was not deleted"
  end
end
