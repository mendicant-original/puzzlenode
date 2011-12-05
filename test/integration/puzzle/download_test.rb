require 'test_helper'

class Puzzle
  class DownloadTest < ActionDispatch::IntegrationTest

    setup do
      @tempfile = Tempfile.new("puzzle_example")
      @tempfile << "Example Text"
      @tempfile.rewind

      @uploaded_file = Rack::Test::UploadedFile.new(@tempfile, "text/plain")
    end

    test "shows a download all button if there are any attachments" do
      puzzle = Factory(:puzzle)
      attachment = puzzle.attachments.create(:file => @uploaded_file)

      visit puzzle_path(puzzle)
      assert page.has_button?("Download All"), "No download all button found"

      cleanup_attachment(attachment)
    end
  end
end
