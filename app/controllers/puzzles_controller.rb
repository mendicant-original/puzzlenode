class PuzzlesController < ApplicationController

  def index
    @puzzles = Puzzle.published(current_user).order("created_at").all
  end

  def tag
    @puzzles = Puzzle.published(current_user).order("created_at").
                tagged_with(params[:tag])

    render :index
  end

  def show
    @puzzle = Puzzle.find(params[:id])

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
