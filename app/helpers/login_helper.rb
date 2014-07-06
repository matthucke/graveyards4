module LoginHelper
  def provider_config
    (SiteConfig[:auth_providers] || {}).with_indifferent_access
  end

  def provider_list
    provider_config.keys.map(&:to_sym)
  end
end
