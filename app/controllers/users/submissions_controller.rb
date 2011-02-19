class Users::SubmissionsController < ApplicationController
  
  def show
    @submission = Submission.find(params[:id])
    @puzzle = @submission.puzzle
  end
end
