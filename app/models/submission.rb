class Submission < ActiveRecord::Base
  belongs_to :puzzle
  belongs_to :user

  before_create :score!

  scope :correct, where(:correct => true)

  validates_presence_of :file
  validate :only_one_correct_submission_per_puzzle_per_user

  attr_accessor :file

  def rating
    @rating ||= Rating.where(:puzzle_id => puzzle_id, :user_id => user_id)
    @rating.first || @rating.new
  end

  private

  def score!
    self.correct = file && puzzle.valid_solution?(file)
    return true
  end

  def only_one_correct_submission_per_puzzle_per_user
    if user && !user.draft_access && user.solution_for(puzzle)
      errors[:base] << "You've already solved this puzzle!"
      return false
    end
  end

end
