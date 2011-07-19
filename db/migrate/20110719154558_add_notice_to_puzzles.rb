class AddNoticeToPuzzles < ActiveRecord::Migration
  def self.up
    add_column :puzzles, :notice, :text
  end

  def self.down
    remove_column :puzzles, :notice
  end
end
