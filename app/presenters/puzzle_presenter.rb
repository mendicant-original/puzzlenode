require 'erb'
require 'zip/zip'
require 'zip/zipfilesystem'

class PuzzlePresenter
  def initialize(puzzle, puzzle_url = nil)
    @puzzle      = puzzle
    @puzzle_url  = puzzle_url
    @md_template = File.read(File.join(Rails.root, 'app/views/puzzles/show.md.erb'))
  end

  def to_markdown
    ERB.new(@md_template).result(binding)
  end

  def generate_zip_file
    raise ArgumentError, "A block must be given" unless block_given?
    temp_file = Tempfile.new("#{@puzzle.slug}-#{Time.now}")

    Zip::ZipOutputStream.open(temp_file.path) do |zos|
      zos.put_next_entry("#{@puzzle.slug}.md")
      zos.puts to_markdown

      @puzzle.attachments.each do |attachment|
        zos.put_next_entry attachment.file_name
        zos.puts File.read(attachment.file_path)
      end
    end

    yield(temp_file)
    temp_file.close
  end

  def puzzle_url(puzzle = @puzzle)
    raise ArgumentError unless @puzzle_url
    @puzzle_url
  end

  private
  attr_reader :puzzle
end
