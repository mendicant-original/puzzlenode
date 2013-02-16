require 'test_helper'

class CommentMailerTest < ActionMailer::TestCase

  context "comment_made" do
    setup do
      @harry = FactoryGirl.create(:user,
        :admin    => false,
        :name     => "Harry Hacker",
        :nickname => "hh4x0r",
        :email    => "harry@hackers.org"
      )
      @sally = FactoryGirl.create(:user,
        :admin    => false,
        :name     => "Sally Solid",
        :nickname => "sallys",
        :email    => "sallys@solid.com"
      )
      @bill = FactoryGirl.create(:user,
        :admin    => false,
        :name     => "Bill Baxter",
        :nickname => "billyb",
        :email    => "billyb@baxter.com"
      )

      @puzzle = FactoryGirl.create(:puzzle)

      create_submission(@puzzle, @harry, true)
      create_submission(@puzzle, @sally, true)
      create_submission(@puzzle, @bill, true)
    end

    test "notifies users when a comment is made" do
      skip "Comment notification disabled"

      assert ActionMailer::Base.deliveries.empty?

      comment = @puzzle.comments.create(:body    => "this is a comment",
                                        :user_id => @harry.id)

      assert_equal 1, ActionMailer::Base.deliveries.size

      message = ActionMailer::Base.deliveries.first

      assert message.bcc.include?(@sally.email)
    end

    test "notifications are only sent to users who have solved the puzzle" do
      skip "Comment notification disabled"

      new_puzzle = FactoryGirl.create(:puzzle)
      create_submission(new_puzzle, @harry, true)
      create_submission(new_puzzle, @bill, true)

      assert ActionMailer::Base.deliveries.empty?

      comment = new_puzzle.comments.create(:body => "Just me and you Bill!",
                  :user_id => @harry.id)

      assert_equal 1, ActionMailer::Base.deliveries.size

      message = ActionMailer::Base.deliveries.first

      assert message.bcc.include?(@bill.email)
      refute message.bcc.include?(@sally.email)
    end

    test "notifications are not sent to users who opt-out" do
      skip "Comment notification disabled"

      @sally.update_attribute(:notify_comment_made, false)

      assert ActionMailer::Base.deliveries.empty?

      comment = @puzzle.comments.create(:body    => "this is a comment",
                                        :user_id => @harry.id)

      assert_equal 1, ActionMailer::Base.deliveries.size

      message = ActionMailer::Base.deliveries.first

      refute message.bcc.include?(@sally.email)
      assert message.bcc.include?(@bill.email)
    end
  end
end
