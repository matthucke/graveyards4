class User < ActiveRecord::Base
  has_many :identities
  has_many :visits
  has_many :photos

  def is_admin?
    self.security_level.to_i >= 1000
  end

end
