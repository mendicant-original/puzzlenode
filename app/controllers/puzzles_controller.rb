require 'zip/zip'
require 'zip/zipfilesystem'

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
      format.md  { send_file description_as_markdown }
      format.zip do
        t = Tempfile.new("#{@puzzle.slug}-#{request.remote_ip}-#{Time.now}")

        Zip::ZipOutputStream.open(t.path) do |zos|
          zos.put_next_entry("#{@puzzle.slug}.md")
          zos.puts description_as_markdown

          @puzzle.attachments.each do |attachment|
            zos.put_next_entry attachment.file_name
            zos.puts File.read(attachment.file_path)
          end
        end

        send_file t.path, :type        => 'application/zip',
                          :disposition => 'attachment',
                          :filename    => "#{@puzzle.slug}.zip"
        t.close
      end
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
  def description_as_markdown
    render_to_string('show.md.erb', :filename => "#{@puzzle.slug}.md")
  end
end
