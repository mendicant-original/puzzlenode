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
    
    assert File.exists?(attachment.file_path), 
           "File was not written to public directory"
    
    cleanup_attachment(attachment)
  end
end
