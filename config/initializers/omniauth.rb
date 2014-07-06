OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :developer unless Rails.env.production?

  if providers = SiteConfig[:auth_providers]
    providers.each_pair do |provider_name, config|
      if c = Rails.application.secrets[provider_name.to_s]
        opts = config[:opts] || {}
        puts "initialize #{provider_name} omni: #{c.inspect} opts:#{opts}"
        Rails.logger.warn "initialize #{provider_name} omni: #{c.inspect} opts:#{opts}"
        provider provider_name.to_sym, c['app_id'], c['secret'], opts
      end
    end
  else
    Rails.logger.warn "WARNING: no auth_providers in application.yml, not configuring omniauth"
  end
end
