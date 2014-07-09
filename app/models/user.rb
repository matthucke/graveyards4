class User < ActiveRecord::Base
  has_many :identities
  has_many :visits
  has_many :photos

end
