class CreateAttachments < ActiveRecord::Migration
  def self.up
    create_table :attachments do |t|
      t.belongs_to :puzzle
      t.string     :file_name
      t.string     :description
      t.timestamps
    end
  end

  def self.down
    drop_table :attachments
  end
end
