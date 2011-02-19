class Puzzles::CommentsController < Puzzles::Base
  before_filter :answered_correct_only
  
  def index
    
  end

  private
  
  def answered_correct_only
    unless @puzzle.answered_correctly?(current_user)
      flash[:error] = "You must correctly answer this puzzle before you can access comments"
      redirect_to puzzle_path(@puzzle)
    end
  end
end
