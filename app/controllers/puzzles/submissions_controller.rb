class Puzzles::SubmissionsController < ApplicationController
  before_filter :find_puzzle

  def new
    @submission = @puzzle.submissions.new
  end
  
  def create
    @submission = @puzzle.submissions.new(params[:submission])
    
    @submission.user = current_user
    
    if @submission.save
      redirect_to user_submission_path(current_user, @submission)
    else      
      render :action => :new
    end
  end
  
  private
  
  def find_puzzle
    @puzzle = Puzzle.find(params[:puzzle_id])
  end
end
