require "ostruct"

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
      if current_user.nil? || !(current_user.draft_access || current_user.admin)
        flash[:error] = "Sorry, this puzzle hasn't been published yet."
        redirect_to root_path
      end
    end
  end

  def attachments
    attachment = Attachment.where("file_name ILIKE ? AND puzzle_id = ?",
      [params[:file], params[:format]].compact.join("."), params[:id]).first

    if attachment
      send_data(File.binread(attachment.file_path))
    else
      raise ActionController::RoutingError.new('Not Found')
    end
  end

end
