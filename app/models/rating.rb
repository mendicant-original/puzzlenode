class Rating < ActiveRecord::Base
  DIFFICULTIES = ["Not Challenging", "Somewhat Challenging", "Very Challenging"]

  belongs_to :user
  belongs_to :puzzle

  validates :difficulty, :inclusion => { :in => DIFFICULTIES }
  validates :user_id,    :presence  => true,
    :uniqueness => { :scope   => :puzzle_id,
                     :message => "has been rated already" }
  validate  :user_answered_correctly

  private

  def user_answered_correctly
    unless puzzle.answered_correctly?(user)
      errors.add(:user, "can't rate the puzzle unless you've sucessfully solved the puzzle")
    end
  end
end
