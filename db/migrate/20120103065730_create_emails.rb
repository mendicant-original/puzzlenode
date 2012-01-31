# Everything listed in this migration will be added to a migration file
# inside of your main app.
class CreateEmails < ActiveRecord::Migration
  def self.up
    create_table :emails do |t|
      t.string :from_address, :null => false

      t.string :reply_to_address,
               :subject

      # The following addresses have been defined as text fields to allow for multiple recipients. These fields could
      # instead be defined as strings, and even indexed, if you'd like to improve search performance and you can
      # confidently limit the size of their contents.

      t.text   :to_address,
               :cc_address,
               :bcc_address

      t.text   :content

      t.datetime :sent_at
      t.timestamps
    end
  end

  def self.down
    drop_table :emails
  end
end
