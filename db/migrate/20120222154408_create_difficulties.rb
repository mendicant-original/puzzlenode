class CreateDifficulties < ActiveRecord::Migration
  def change
    create_table :difficulties do |t|
      t.references :user
      t.references :puzzle
      t.string :rating

      t.timestamps
    end

    add_index :difficulties, :user_id
    add_index :difficulties, :puzzle_id
    add_index :difficulties, [:user_id, :puzzle_id], :unique => true
  end
end
