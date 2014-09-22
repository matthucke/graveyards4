class User < ActiveRecord::Base
  has_many :identities
  has_many :visits
  has_many :photos
  has_many :expeditions

  def admin?
    self.security_level.to_i >= 1000
  end

  def avatar
    ident = identities.find(&:avatar)
    ident ? ident.avatar : nil
  end
end
