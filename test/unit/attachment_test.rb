require 'test_helper'

class AttachmentTest < ActiveSupport::TestCase

  setup do
    @tempfile = Tempfile.new("puzzle_example")
    @tempfile << "Example Text"
    @tempfile.rewind

    @uploaded_file = Rack::Test::UploadedFile.new(@tempfile, "text/plain")
  end

  test "must write file name to the database" do
    puzzle = build_puzzle

    attachment = puzzle.attachments.create(:file => @uploaded_file)

    assert_equal File.basename(@tempfile), attachment.file_name

    cleanup_attachment(attachment)
  end

  test "writes file to public directory" do
    puzzle = build_puzzle

    attachment = puzzle.attachments.create(:file => @uploaded_file)

    assert File.exists?(attachment.file.path),
           "File was not written to public directory"

    cleanup_attachment(attachment)
  end

  test "deletes file when record is destroyed" do
    puzzle = build_puzzle

    attachment = puzzle.attachments.create(:file => @uploaded_file)

    path = attachment.file.path

    assert File.exists?(path),
           "File was not written to public directory"

    attachment.destroy

    refute File.exists?(path),
           "File was not removed from the public directory"
  end

  test "does not throw an error when file is missing" do
    puzzle = build_puzzle

    attachment = puzzle.attachments.create(:file => @uploaded_file)

    path = attachment.file.path

    assert File.exists?(path),
           "File was not written to public directory"

    cleanup_attachment(attachment)

    attachment.destroy

    assert attachment.destroyed?, "Attachment was not destroyed"

    refute File.exists?(path),
           "File was not removed from the public directory"
  end
end
