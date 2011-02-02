class User < ActiveRecord::Base
  has_many :authorizations
end
