class GraveyardDecorator < Draper::Decorator
  delegate_all

  # Define presentation-specific methods here. Helpers are accessed through
  # `helpers` (aka `h`). You can override attributes, for example:
  #
  #   def created_at
  #     helpers.content_tag :span, class: 'time' do
  #       object.created_at.strftime("%a %m/%d/%y")
  #     end
  #   end

  def lat_or_unknown(unknown='unknown')
    located? ? format_coord(lat) : unknown
  end

  def lng_or_unknown(unknown='unknown')
    located? ? format_coord(lng) : unknown
  end

  def format_coord coord
    "%0.5f" % coord
  end
end
