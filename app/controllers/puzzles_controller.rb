class PuzzlesController < ApplicationController
  
  def index
    @puzzles = Puzzle.published(current_user).order("created_at").all
  end
  
  def show
    @puzzle = Puzzle.find(params[:id])
    @correct_submissions = @puzzle.solved_by.eligible_for_display
    @total_submissions = @puzzle.submissions.includes(:user).merge(User.eligible_for_display)
    
    unless @puzzle.published?
      if current_user.nil? || !current_user.draft_access
        flash[:error] = "Sorry, this puzzle hasn't been published yet."
        redirect_to root_path
      end
    end
  end
  
  def attachments
    path = File.join(Rails.root, "public", "attachments", params[:id], 
                     [params[:file], params[:format]].compact.join("."))
    
    send_data(File.binread(path))
  end
  
end
