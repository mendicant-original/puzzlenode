class AddSlugToPuzzles < ActiveRecord::Migration
  def change
    add_column :puzzles, :slug, :string
  end
end
