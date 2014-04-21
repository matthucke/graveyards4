class Identity < ActiveRecord::Base
  belongs_to :user

  # based on:
  # https://github.com/intridea/omniauth/wiki/Managing-Multiple-Providers

  def self.from_omniauth(auth)
    where(provider: auth['provider'], uid: auth['uid']).first_or_initialize do |ident|
      ident.provider_text = auth.to_yaml
      ident.user = User.from_omniauth(auth)
      ident.save
    end
  end

end
