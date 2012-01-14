class AddAllowSourceUrlToPuzzles < ActiveRecord::Migration
  def self.up
    add_column :puzzles, :allow_source_url, :boolean, :default => false
  end

  def self.down
    remove_column :puzzles, :allow_source_url
  end
end
