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
      format.md  { send_puzzle_as_markdown }
      format.zip { send_puzzle_as_zip }
    end
  end

  def attachments
    puzzle = Puzzle.find_by_slug(params[:slug])
    # TODO Remove legacy Puzzle#id based routes
    puzzle ||= Puzzle.find(params[:slug])

    attachment = Attachment.where("file_name ILIKE ? AND puzzle_id = ?",
      [params[:file], params[:format]].compact.join("."), puzzle.id).first

    if attachment
      send_data(File.binread(attachment.file_path))
    else
      raise ActionController::RoutingError.new('Not Found')
    end
  end

  private
  def send_puzzle_as_markdown
    send_data puzzle_presenter.to_markdown, :filename => "#{@puzzle.slug}.md"
  end

  def send_puzzle_as_zip
    puzzle_presenter.generate_zip_file do |zip|
      send_file zip.path, :type        => 'application/zip',
                          :disposition => 'attachment',
                          :filename    => "#{@puzzle.slug}.zip"
    end
  end

  def puzzle_presenter
    PuzzlePresenter.new(@puzzle, puzzle_url(@puzzle))
  end
end
