class RemoveContestantFromUsers < ActiveRecord::Migration
  def self.up
    remove_column :users, :contestant
  end

  def self.down
    add_column :users, :contestant, :boolean, :default => false
  end
end
