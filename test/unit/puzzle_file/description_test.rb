require_relative '../../bare_test_helper'
require_relative '../../../app/models/puzzle_file/description'

class PuzzleDescriptionFileTest < ActiveSupport::TestCase
  setup do
    @puzzle = stub(:id          => 1,
                   :name        => "[#1] Six Degrees of Separation",
                   :slug        => "1-six-degrees-of-separation",
                   :description => "Find connections!")
    @desc_file = PuzzleFile::Description.new(@puzzle, FILE_DIRECTORY)
  end

  test "must generate a filename with markdown extension from its name attribute" do
    assert_equal @desc_file.file_name, "1-six-degrees-of-separation.markdown"
  end

  test "must generate a filepath" do
    expected_path = (FILE_DIRECTORY + "/1-six-degrees-of-separation.markdown")
    assert_equal @desc_file.file_path, expected_path
  end

  test "must save the file to the right location" do
    refute File.exists?(@desc_file.file_path)
    @desc_file.save
    assert File.exists?(@desc_file.file_path)
  end

  test "must save the file with the correct contents" do
    @desc_file.save
    actual_file_contents = File.open(@desc_file.file_path).read
    assert_equal @desc_file.contents, actual_file_contents
  end

  test "must delete the file" do
    @desc_file.save
    assert File.exists?(@desc_file.file_path), "File does not exist before deleting"
    @desc_file.delete
    refute File.exists?(@desc_file.file_path), "File was not deleted"
  end

  test "knows if a file is saved to disk" do
    refute @desc_file.saved?
    @desc_file.save
    assert @desc_file.saved?
  end
end
