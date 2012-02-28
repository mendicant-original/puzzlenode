class CreateRatings < ActiveRecord::Migration
  def change
    create_table :ratings do |t|
      t.references :user
      t.references :puzzle
      t.string     :difficulty

      t.timestamps
    end

    add_index :ratings, :user_id
    add_index :ratings, :puzzle_id
    add_index :ratings, [:user_id, :puzzle_id], :unique => true
  end
end
