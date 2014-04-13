json.array!(@counties) do |county|
  json.extract! county, :id, :state_id, :name, :county_type, :path, :full_path
  json.url county_url(county, format: :json)
end
