json.array!(@visits) do |visit|
  json.extract! visit, :id, :user_id, :graveyard_id, :visited_at, :visit_type, :notes
  json.url visit_url(visit, format: :json)
end
