class AddPublishedFlagToPuzzles < ActiveRecord::Migration
  def self.up
    add_column :puzzles, :published, :boolean, :default => false

    puzzles = Puzzle.where("released_on <= ?", Date.today)

    puzzles.each do |p|
      p.published = true
      p.save
    end
  end

  def self.down
    remove_column :puzzles, :published
  end
end
