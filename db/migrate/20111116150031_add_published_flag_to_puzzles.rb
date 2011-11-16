class AddPublishedFlagToPuzzles < ActiveRecord::Migration
  def self.up
    add_column :puzzles, :published, :boolean, :default => false

    Puzzle.where("released_on <= ?", Date.today).update_all(:published => true)
  end

  def self.down
    remove_column :puzzles, :published
  end
end
