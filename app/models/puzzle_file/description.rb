require_relative 'generic_file'

module PuzzleFile
  class Description
    include GenericFile

    def file_name
      @puzzle.slug + ".markdown"
    end

    # Creates the directory if it doesn't exist and saves the file
    # Returns the PuzzleFile instance
    def save
      FileUtils.mkdir_p(directory)
      File.open(file_path, "wb") { |f| f.write(contents) }
      self
    end

    # Pulls data from the puzzle to create the file contents
    # Change this method to customize the file contents, for example to
    # add published date or any other information.
    def contents
      @puzzle.name + "\n\n" + @puzzle.description
    end
  end
end
