class AddNotifyCommentMadeToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :notify_comment_made, :boolean, :default => false, :null => false
  end

  def self.down
    remove_column :users, :notify_comment_made
  end
end
