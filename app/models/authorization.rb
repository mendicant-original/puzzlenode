class Authorization < ActiveRecord::Base
  belongs_to :user
  
  validates_presence_of   :user_id, :uid, :provider
  validates_uniqueness_of :uid, :scope => :provider
  
  def self.find_from_hash(hash)      
    auth = find_by_provider_and_uid(hash['provider'], hash['uid'].to_s)
    return unless auth

    auth.user.refresh_names(hash)

    auth
  end

  def self.create_from_hash(hash, user = nil)
    user ||= User.create_from_hash!(hash)
    Authorization.create(:user => user, :uid => hash['uid'].to_s, :provider => hash['provider'])
  end
end
