class AddDraftAccessToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :draft_access, :boolean, :default => false
  end

  def self.down
    remove_column :users, :draft_access
  end
end
