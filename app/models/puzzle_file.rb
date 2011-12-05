class PuzzleFile
  # The purpose of these class methods are to provide a nicer interface.
  # It does not make a lot of sense to say PuzzleFile.new as that would
  # confuse the reader into thinking a new file is being created when in
  # fact we are just instantiating the class. PuzzleFile.save(puzzle) is
  # much more intention revealing.
  class << self
    def save(puzzle)
      new(puzzle).save_new_copy
    end

    def delete(puzzle)
      new(puzzle).delete
    end

    def path_for(puzzle)
      new(puzzle).file_path
    end

    def saved?(puzzle)
      new(puzzle).file_exists?
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
  # Returns no useful value
  def save_new_copy
    delete if file_exists?
    save
  end

  # Creates the directory if it doesn't exist and saves the file
  # Returns no useful value
  def save
    FileUtils.mkdir_p(directory)
    File.open(file_path, "wb") { |f| f.write(contents) }
  end

  # Deletes the file at the file path
  # Returns no useful value
  def delete
    FileUtils.rm(file_path)
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
    @puzzle.id.to_s + "-" + @puzzle.name.titleize.gsub(" ", "").underscore + ".markdown"
  end

  def file_exists?
    File.exists?(file_path)
  end

  def public_path
    "/puzzles/#{file_name}"
  end
end
