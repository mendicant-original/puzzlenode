require_relative 'generic_file'
require_relative 'description'
require 'zip/zip'

module PuzzleFile
  class Zipped
    include GenericFile

    def file_name
      @puzzle.slug + ".zip"
    end

    def save
      puzzle_files = [@puzzle.description_file] | @puzzle.attachments

      Zip::ZipOutputStream.open(file_path) do |zos|
        puzzle_files.each do |file|
          zos.put_next_entry file.file_name
          zos.puts File.read(file.file_path)
        end
      end
    end
  end
end
