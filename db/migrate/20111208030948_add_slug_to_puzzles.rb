class AddSlugToPuzzles < ActiveRecord::Migration
  def self.up
    add_column :puzzles, :slug, :string

    Puzzle.find_each do |puzzle|
      puzzle.update_attribute :slug, Slugger.generate(puzzle.name)
    end
  end

  def self.down
    remove_column :puzzles, :slug
  end
end
