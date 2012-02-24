require 'fileutils'

module PuzzleFile
  module GenericFile
    def initialize(puzzle, path)
      @puzzle = puzzle
      @path = path
    end

    def file_name
      raise "file_name must be defined"
    end

    def save
      raise "save must be defined"
    end

    def directory
      File.expand_path(File.join(@path))
    end

    # Refers to the full path to the location on disk for the puzzle file
    # Returns a String
    def file_path
      File.join(directory, file_name)
    end

    # Overwrites a file if one already exists, otherwise it just saves
    # Returns the PuzzleFile instance
    def save_new_copy
      delete and save
      self
    end

    # Deletes the file at the file path
    # Returns no useful value
    def delete
      FileUtils.rm(file_path) if saved?
    end

    def saved?
      File.exists?(file_path)
    end

    def public_path
      "/puzzles/#{file_name}"
    end
  end
end
