class CreateSubmissions < ActiveRecord::Migration
  def self.up
    create_table :submissions do |t|
      t.belongs_to :user
      t.belongs_to :puzzle
      t.boolean :correct
      t.text :source_url
      t.timestamps
    end
  end

  def self.down
    drop_table :submissions
  end
end
