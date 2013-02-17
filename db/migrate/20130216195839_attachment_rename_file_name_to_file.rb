class AttachmentRenameFileNameToFile < ActiveRecord::Migration
  def up
    rename_column :attachments, :file_name, :file
  end

  def down
    rename_column :attachments, :file, :file_name
  end
end
