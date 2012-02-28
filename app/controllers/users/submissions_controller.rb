class Users::SubmissionsController < ApplicationController
  before_filter :find_submission
  before_filter :current_user_only
  
  def show
    @puzzle = @submission.puzzle
    @difficulty = @submission.difficulty if @submission.correct?
  end
  
  def update
    if @submission.update_attribute(:source_url, params[:submission][:source_url])
      flash[:notice] = "Source URL sucessfully updated."
      redirect_to puzzle_comments_path(@submission.puzzle)
    else
      # TODO: Error Handling
      flash[:error] = "There was a problem updating your submission."
      redirect_to puzzle_path(@puzzle)
    end
  end
  
  private
  
  def find_submission
    @submission = Submission.find(params[:id])
  end
  
  def current_user_only
    unless @submission.user == current_user
      flash[:error] = "You can only edit your own submissions!"
      redirect_to puzzle_path(@puzzle)
    end
  end
end
