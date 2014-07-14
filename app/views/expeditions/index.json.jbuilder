json.array!(@expeditions) do |expedition|
  json.extract! expedition, :id, :user_id, :name, :started_on, :ended_on, :notes
  json.url expedition_url(expedition, format: :json)
end
