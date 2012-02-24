require_relative '../../bare_test_helper'
require_relative '../../../app/models/puzzle_file/generic_file'
require 'tempfile'

class PuzzleFileGenericFileTest < ActiveSupport::TestCase
  class SamplePuzzleFile
    include PuzzleFile::GenericFile

    def file_name
      "some_dynamic_name.extension"
    end

    def save; end
  end

  setup do
    @file = SamplePuzzleFile.new(stub, "/")
  end

  test "directory returns the correct path" do
    assert_equal @file.directory, "/"
  end

  test "file path returns the full path to the file" do
    assert_equal @file.file_path, ("/some_dynamic_name.extension")
  end

  test "deletes the file if it has been saved" do
    @file.stubs(:saved?).returns(true)
    FileUtils.expects(:rm).with(@file.file_path)
    @file.delete
  end

  test "does not execute if the file has not been saved" do
    @file.stubs(:saved?).returns(false)
    FileUtils.expects(:rm).with(@file.file_path).never
    @file.delete
  end

  test "saved? returns true if the file has been saved" do
    some_file = Tempfile.new('foo')
    @file.stubs(:file_path).returns(some_file.path)
    assert @file.saved?
  end

  test "saved? returns false if the file has not been saved" do
    @file.stubs(:file_path).returns("/this/file/certainly/does/not/exist.lol")
    refute @file.saved?
  end
end
