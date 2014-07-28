class GraveyardDecorator < Draper::Decorator
  delegate_all

  BASE_URL = SiteConfig.base_url

  def lat_or_unknown(unknown='unknown')
    located? ? format_coord(lat) : unknown
  end

  def lng_or_unknown(unknown='unknown')
    located? ? format_coord(lng) : unknown
  end

  def format_coord coord
    "%0.5f" % coord
  end

  def full_url
    BASE_URL + graveyard.to_url.to_s
  end

  # For the NEW PHOTO form
  def new_photo(attrs={})
    graveyard.photos.new(attrs).tap do |p|
      p.sort_order = p.default_sort_order
    end
  end
end
