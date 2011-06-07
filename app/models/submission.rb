class Submission < ActiveRecord::Base
  belongs_to :puzzle
  belongs_to :user

  before_create :score!
  
  scope :correct, where(:correct => true)

  validates_presence_of :file

  attr_accessor :file

  private

  def score!
    self.correct = file && puzzle.valid_solution?(file)
    return true
  end

end
