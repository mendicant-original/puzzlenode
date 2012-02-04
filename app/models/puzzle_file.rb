class PuzzleFile
  class << self
    def find(puzzle)
      new(puzzle)
    end

    def path_for(puzzle)
      new(puzzle).file_path
    end
  end

  def initialize(puzzle)
    @puzzle = puzzle
  end

  # Pulls data from the puzzle to create the file contents
  # Change this method to customize the file contents, for example to
  # add published date or any other information.
  def contents
    @puzzle.name + "\n\n" + @puzzle.description
  end

  # Overwrites a file if one already exists, otherwise it just saves
  # Returns the PuzzleFile instance
  def save_new_copy
    delete and save
    self
  end

  # Creates the directory if it doesn't exist and saves the file
  # Returns the PuzzleFile instance
  def save
    FileUtils.mkdir_p(directory)
    File.open(file_path, "wb") { |f| f.write(contents) }
    self
  end

  # Deletes the file at the file path
  # Returns no useful value
  def delete
    FileUtils.rm(file_path) if file_exists?
  end

  # Refers to the full path to the location on disk for the puzzle file
  # Returns a String
  def file_path
    File.join(directory, file_name)
  end

  def directory
    File.join(Rails.root, 'public', 'puzzles')
  end

  def file_name
    @puzzle.slug + ".markdown"
  end

  def file_exists?
    File.exists?(file_path)
  end

  def public_path
    "/puzzles/#{file_name}"
  end
end
