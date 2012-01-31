require 'test_helper'

class CommentMailerTest < ActionMailer::TestCase
  test "notify all interested users when a comment is made" do
    CommentMailer.comment_made("subject", "to", "body")
    assert !ActionMailer::Base.deliveries.empty?
  end
end
