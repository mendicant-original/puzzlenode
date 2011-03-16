class Submission < ActiveRecord::Base
  belongs_to :puzzle
  belongs_to :user
  
  scope :correct, lambda { where(:correct => true) }

  attr_accessor :file

  before_create do |record|
    record.correct = record.puzzle.valid_solution?(record.file)
    
    return true
  end
end
