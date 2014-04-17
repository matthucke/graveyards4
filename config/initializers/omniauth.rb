OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  # TODO: make this more dynamic
  if c = Rails.application.secrets.facebook
  	provider :facebook, c['app_id'], c['secret']
  end
end
