require_relative '../../bare_test_helper'
require_relative '../../../app/models/puzzle_file/zipped'
require 'tempfile'

class PuzzleZippedFileTest < ActiveSupport::TestCase
  setup do
    @puzzle = stub(:id          => 1,
                   :name        => "[#1] Six Degrees of Separation",
                   :slug        => "1-six-degrees-of-separation",
                   :description => "Find connections!",
                   :attachments => [])

    @puzzle = fake_description_file_for(@puzzle)

    @zip = PuzzleFile::Zipped.new(@puzzle, PUZZLE_DIRECTORY)
  end

  test "must generate a filename with markdown extension from its name attribute" do
    assert_equal @zip.file_name, "1-six-degrees-of-separation.zip"
  end

  test "must generate a filepath" do
    expected_path = (PUZZLE_DIRECTORY + "/public/puzzles/" + "1-six-degrees-of-separation.zip")
    assert_equal @zip.file_path, expected_path
  end

  test "must save the zip with the description file and attachments" do
    @puzzle = fake_attachments_for(@puzzle)
    @zip.save

    Zip::ZipInputStream.open(@zip.file_path) do |zis|
      entry = zis.get_next_entry
      assert_equal entry.name, "1-six-degrees-of-separation.markdown"
      assert_equal zis.gets.chomp, "Find connections!"

      entry = zis.get_next_entry
      assert_equal entry.name, "sample_1.txt"
      assert_equal zis.gets.chomp, "body 1"

      entry = zis.get_next_entry
      assert_equal entry.name, "sample_2.txt"
      assert_equal zis.gets.chomp, "body 2"
    end
  end

  test "must delete the file" do
    @zip.save
    assert File.exists?(@zip.file_path), "File does not exist before deleting"
    @zip.delete
    assert !File.exists?(@zip.file_path), "File was not deleted"
  end

  test "knows if a file is saved to disk" do
    refute @zip.saved?
    @zip.save
    assert @zip.saved?
  end
end
