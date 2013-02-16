require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
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
      :email    => "sallys@solid.com",
    )
  end

  test "leaderboard is sorted by number of correct solutions" do
    5.times { |i| create_submission(FactoryGirl.create(:puzzle), @harry, i.zero?) }
    2.times { |i| create_submission(FactoryGirl.create(:puzzle), @sally, true) }

    leaderboard = User.leaderboard
    assert_equal [@sally.id, @harry.id], leaderboard.map(&:id)

    assert_equal 2, leaderboard.first.solved.to_i

    assert_equal 1, leaderboard.last.solved.to_i
  end

  test "ties are broken by the fastest submission" do
    2.times { |i| create_submission(FactoryGirl.create(:puzzle), @harry, true) }
    2.times { |i| create_submission(FactoryGirl.create(:puzzle), @sally, true) }

    assert_equal [@harry.id, @sally.id], User.leaderboard.map(&:id)
  end

  test "admins are excluded from the leaderboard" do
    admin = @harry
    admin.update_attribute(:admin, true)

    2.times { |i| create_submission(FactoryGirl.create(:puzzle), admin, true) }
    2.times { |i| create_submission(FactoryGirl.create(:puzzle), @sally, true) }

    assert_equal [@sally.id], User.leaderboard.map(&:id)
  end

  test "users with draft access are excluded from the leaderboard" do
    draft_access_user = @sally
    draft_access_user.update_attribute(:draft_access, true)

    2.times { |i| create_submission(FactoryGirl.create(:puzzle), draft_access_user, true) }
    2.times { |i| create_submission(FactoryGirl.create(:puzzle), @harry, true) }

    assert_equal [@harry.id], User.leaderboard.map(&:id)
  end

  test "calculates leaderboard position" do
    create_submission(FactoryGirl.create(:puzzle), @sally, true)

    assert_equal 1, @sally.leaderboard_position
    assert_nil @harry.leaderboard_position

    0.upto(15) do |i|
      user = FactoryGirl.create(:user)
      create_submission(FactoryGirl.create(:puzzle), user, true)
    end

    create_submission(FactoryGirl.create(:puzzle), @harry, true)
    assert_equal 18, @harry.leaderboard_position
  end

  test "get leaderboard neighborhood" do
    create_submission(FactoryGirl.create(:puzzle), @sally, true)

    0.upto(4) do |i|
      user = FactoryGirl.create(:user)
      create_submission(FactoryGirl.create(:puzzle), user, true)
    end

    create_submission(FactoryGirl.create(:puzzle), @harry, true)

    7.upto(15) do |i|
      user = FactoryGirl.create(:user)
      create_submission(FactoryGirl.create(:puzzle), user, true)
    end

    leaderboard = @harry.local_leaderboard
    assert_equal @harry.name, leaderboard[5].name

    leaderboard = @sally.local_leaderboard
    assert_equal @sally.name, leaderboard[0].name
  end
end
