class AddContestantToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :contestant, :boolean, :default => false
  end

  def self.down
    remove_column :users, :contestant
  end
end
