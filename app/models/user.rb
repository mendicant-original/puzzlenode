class User < ActiveRecord::Base
  has_many :authorizations
  has_many :announcements, :foreign_key => "author_id"
  
  def self.create_from_hash!(hash)
    create(:name => hash['user_info']['name'])
  end
end
