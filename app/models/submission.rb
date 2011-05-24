class Submission < ActiveRecord::Base
  belongs_to :puzzle
  belongs_to :user

  before_create :score!
  
  scope :correct, where(:correct => true)

  attr_accessor :file

  private

  def score!
    self.correct = file && puzzle.valid_solution?(file)
    return true
  end

end
