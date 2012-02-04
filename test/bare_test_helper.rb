require 'active_support'
require 'test/unit'
require 'fileutils'

class ActiveSupport::TestCase
  PUZZLE_DIRECTORY = File.expand_path(File.join(File.dirname(__FILE__), 'temp'))
  FILE_DIRECTORY   = PUZZLE_DIRECTORY + "/public/puzzles"

  def cleanup_puzzles
    FileUtils.rm_rf(PUZZLE_DIRECTORY)
    FileUtils.rm_rf(FILE_DIRECTORY)
    FileUtils.mkdir_p(PUZZLE_DIRECTORY)
    FileUtils.mkdir_p(FILE_DIRECTORY)
  end

  def fake_attachments_for(puzzle)
    attachment_directory = PUZZLE_DIRECTORY + "/#{puzzle.id}"
    FileUtils.mkdir_p(attachment_directory)

    2.times do |i|
      file_name = "sample_#{i+1}.txt"
      file_path = attachment_directory + "/#{file_name}"

      sample = File.open(file_path, 'w') do |f|
        f.puts "body #{i+1}"
      end

      puzzle.attachments << stub(:file_name => file_name,
                                 :file_path => file_path)
    end

    puzzle
  end

  def fake_description_file_for(puzzle)
    file_name = puzzle.slug + ".markdown"
    file_path = PUZZLE_DIRECTORY + "/#{file_name}"
    sample = File.open(file_path, 'w') do |f|
      f.puts puzzle.description
    end
    description_file = stub(:file_name => puzzle.slug + ".markdown",
                            :file_path => file_path)

    puzzle.stubs(:description_file).returns(description_file)
    puzzle
  end

  setup do
    cleanup_puzzles
  end
end

require 'mocha'
