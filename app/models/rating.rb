class Rating < ActiveRecord::Base
  DIFFICULTIES = ["Not Challenging", "Somewhat Challenging", "Very Challenging"]

  belongs_to :user
  belongs_to :puzzle

  validates :rate, :inclusion => {:in => DIFFICULTIES}
  validates :user_id, :presence => true, :uniqueness => {:scope => :puzzle_id, :message => "has been rated already"}
  validate :check_user_got_correct_sumsission

  def check_user_got_correct_sumsission
    errors.add(:user, "can't rate the puzzle unless you get correct submission.") unless puzzle.answered_correctly?(user)
  end
end
