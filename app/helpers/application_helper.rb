module ApplicationHelper
  # used for anything that implements to_url - a County or Graveyard generally
  def map_url_for(obj)
    obj.to_url.to_s + "/map"
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
