class BoundaryEncoder
  def string_to_polyline str
    points_to_polyline(string_to_points(str))
  end

  # return string like: "_ft}FnuqwOovs@nd@~p@nxaA_sNfE?oaD_ePfEnKwp|A..."
  def points_to_polyline points
    Polylines::Encoder.encode_points points
  end

  # in: "41.724 -87.914;41.994 -87.920;41.986 -88.262;42.066 -88.263; ...]
  # out: [[41.724, -87.914], [41.994, -87.92], [41.986, -88.262], ...
  def string_to_points str
    str.split(';').map(&:strip).map { |p| p.split(/\s+/).map(&:to_f) }
  end
end