class CreatePuzzles < ActiveRecord::Migration
  def self.up
    create_table :puzzles do |t|
      t.text :name
      t.text :short_description
      t.text :description
      t.text :fingerprint
      t.timestamps
    end
  end

  def self.down
    drop_table :puzzles
  end
end
