module UserFactory
  def self.user_from_omniauth(auth, identity=nil)
    factory_from_omniauth(auth, identity).find_or_create_user
  end

  def self.factory_from_omniauth(auth, identity=nil)
    UserFactory::Base.new(auth, identity)
  end
end