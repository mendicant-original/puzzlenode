require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  def setup
    @harry = Factory(:user,
      :admin    => false,
      :name     => "Harry Hacker",
      :nickname => "hh4x0r",
      :email    => "harry@hackers.org",
      :notify_comment_made => true,
    )
    @sally = Factory(:user,
      :admin    => false,
      :name     => "Sally Solid",
      :nickname => "sallys",
      :email    => "sallys@solid.com",
      :notify_comment_made => true,
    )
  end

  test "Comment#notify_comment_made should email the other users when a comment is made" do
    create_submission(Factory(:puzzle), @harry, true)
    create_submission(Factory(:puzzle), @sally, true)
    puzzle = Factory(:puzzle)
    comment = puzzle.comments.create(:body => "this is a comment",
                                     :user_id => @harry.id)
    comment.notify_comment_made
    assert !ActionMailer::Base.deliveries.empty?
  end
end
