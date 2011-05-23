class AddCreatedByAndReleasedOnToPuzzles < ActiveRecord::Migration
  def self.up
    add_column :puzzles, :created_by, :string
    add_column :puzzles, :created_by_url, :string
    add_column :puzzles, :released_on, :date
  end

  def self.down
    remove_column :puzzles, :created_by
    remove_column :puzzles, :created_by_url
    remove_column :puzzles, :released_on
  end
end
