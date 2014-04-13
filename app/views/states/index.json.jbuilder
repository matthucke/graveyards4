json.array!(@states) do |state|
  json.extract! state, :id, :state_code, :country_code, :name, :path
  json.url state_url(state, format: :json)
end
