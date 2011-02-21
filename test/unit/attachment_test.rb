require 'test_helper'

class AttachmentTest < ActiveSupport::TestCase
  
  test "must write file name to the database" do
    tempfile = Tempfile.new("puzzle_example")
    tempfile << "Example Text"
    tempfile.rewind

    puzzle = build_puzzle
    
    attachment = puzzle.attachments.create(:file => tempfile)
    
    assert_equal File.basename(tempfile), attachment.file_name
    
    cleanup_attachment(attachment)
  end
 
  test "writes file to public directory" do
    tempfile = Tempfile.new("puzzle_example")
    tempfile << "Example Text"
    tempfile.rewind

    puzzle = build_puzzle
    
    attachment = puzzle.attachments.create(:file => tempfile)
    
    assert File.exists?(attachment.file_path), 
           "File was not written to public directory"
    
    cleanup_attachment(attachment)
  end
end
