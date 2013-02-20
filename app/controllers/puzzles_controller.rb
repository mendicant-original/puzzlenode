class PuzzlesController < ApplicationController
  respond_to :html

  def index
    @puzzles = Puzzle.visible_to(current_user)

    respond_with(@puzzles)
  end

  def tag
    @puzzles = Puzzle.visible_to(current_user).
                tagged_with(params[:tag])

    respond_with(@puzzles) do |format|
      format.html { render :index }
    end
  end

  def show
    @puzzle   = Puzzle.find_by_slug(params[:id])
    # TODO Remove legacy Puzzle#id based routes
    @puzzle ||= Puzzle.find(params[:id])

    unless @puzzle.published?
      if current_user.nil? || !(current_user.draft_access || current_user.admin)
        flash[:error] = "Sorry, this puzzle hasn't been published yet."
        redirect_to root_path
      end
    end

    respond_with(@puzzle) do |format|
      format.md do
        send_data render_to_string('show', :filename => "#{@puzzle.slug}.md")
      end
    end
  end
end
