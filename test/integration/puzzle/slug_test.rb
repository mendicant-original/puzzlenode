require 'test_helper'

class SlugTest < ActionDispatch::IntegrationTest
  test "access puzzle by slug" do
    puzzle = FactoryGirl.create(:puzzle,
                     :name => "[#1] A regular puzzle",
                     :slug => "1-a-regular-puzzle")

    visit puzzle_path("1-a-regular-puzzle")

    assert_content "A regular puzzle"
  end

  test "raises a routing error when the slug does not exist" do
    assert_raise ActiveRecord::RecordNotFound do
      visit puzzle_path("this-thing-does-not-exist")
    end
  end
end
