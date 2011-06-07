require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @harry = Factory(:user,
      :admin    => false,
      :name     => "Harry Hacker",
      :nickname => "hh4x0r",
      :email    => "harry@hackers.org"
    )
    @sally = Factory(:user,
      :admin    => false,
      :name     => "Sally Solid",
      :nickname => "sallys",
      :email    => "sallys@solid.com",
    )

    @puzzle = Factory(:puzzle)
  end

  test "leaderboard is sorted by number of correct solutions" do
    5.times { |i| create_submission(@harry, i.zero?) }
    2.times { |i| create_submission(@sally, true) }

    leaderboard = User.leaderboard
    assert_equal [@sally.id, @harry.id], leaderboard.map(&:id)

    assert_equal 2, leaderboard.first.solved.to_i
    assert_equal 2, leaderboard.first.attempts.to_i

    assert_equal 1, leaderboard.last.solved.to_i
    assert_equal 5, leaderboard.last.attempts.to_i
  end

  test "ties are broken by the fewest number of attempts" do
    5.times { |i| create_submission(@harry, i < 2) }
    2.times { |i| create_submission(@sally, true) }

    assert_equal [@sally.id, @harry.id], User.leaderboard.map(&:id)
  end

  test "remaining ties are broken by the fastest submission" do
    2.times { |i| create_submission(@harry, true) }
    2.times { |i| create_submission(@sally, true) }

    assert_equal [@harry.id, @sally.id], User.leaderboard.map(&:id)
  end

  test "admins are excluded from the leaderboard" do
    admin = @harry
    admin.update_attribute(:admin, true)

    2.times { |i| create_submission(admin, true) }
    2.times { |i| create_submission(@sally, true) }

    assert_equal [@sally.id], User.leaderboard.map(&:id)
  end

  private

  def create_submission(user, correct)
    s = Submission.create(:user => user, :puzzle => @puzzle, :file => Tempfile.new('solution'))
    s.update_attribute(:correct, correct)
  end
end
