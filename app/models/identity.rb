class Identity < ActiveRecord::Base
  belongs_to :user

  delegate :full_name, to: :user, allow_nil: true

  def provider_icon
    "/images/icons/32/#{self.provider}.png"
  end

  # based on:
  # https://github.com/intridea/omniauth/wiki/Managing-Multiple-Providers
  def self.from_omniauth(auth)
    ident = where(attrs_from_omniauth(auth)).first_or_initialize do |ident|
      raise "#{ident.provider} user id cannot be empty" if ident.uid.to_s.blank?
      ident.provider_text = auth.to_yaml
      ident.save
    end

    unless ident.user
      ident.user = UserFactory.user_from_omniauth(auth, ident)
    end

    img = auth['info']['image']
    unless img.blank?
      ident.avatar = img
    end

    ident.save if ident.changed?
    ident
  end

  def self.attrs_from_omniauth(auth)
    attrs = {
        provider: auth.provider,
        uid: auth.uid
    }
  end
end
