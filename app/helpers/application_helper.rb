module ApplicationHelper

  def current_user
    @current_user
  end
  def current_identity
    @identity
  end

  # used for anything that implements to_url - a County or Graveyard generally
  # /Illinois/map
  # /Illinois/Cumberland/map
  def map_url_for(obj)
    obj.to_url.to_s + "/map"
  end

  # /Illinois/list
  # /Illinois/Edwards/list
  def list_url_for(obj)
    obj.to_url.to_s + "/list"
  end

  def full_url(url)
    url.to_s =~ /^http/ ? url : base_url + url
  end

  def base_url
    'http://graveyards.com'
  end

  def google_maps_url lat, lng
    return nil unless lat && lng

    return "http://maps.google.com/maps?q=#{lat}+#{lng}"
  end
end
