json.array!(@county_cemetery_lists) do |county_cemetery_list|
  json.extract! county_cemetery_list, :id, :name, :state_id
  json.url county_cemetery_list_url(county_cemetery_list, format: :json)
end
