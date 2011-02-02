class CreateAuthorizations < ActiveRecord::Migration
  def self.up
    create_table :authorizations do |t|
      t.belongs_to :user
      t.string     :provider
      t.string     :uid

      t.timestamps
    end
  end

  def self.down
    drop_table :authorizations
  end
end
