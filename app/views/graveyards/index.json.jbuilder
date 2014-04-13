json.array!(@graveyards) do |graveyard|
  json.extract! graveyard, :id, :feature_type, :county_id, :status, :name, :path, :lat, :lng, :year_started, :usgs_id, :usgs_map, :homepage
  json.url graveyard_url(graveyard, format: :json)
end
