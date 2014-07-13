json.array!(@articles) do |article|
  json.extract! article, :id, :status, :section, :graveyard_id, :author_id, :headline, :path, :published_at, :teaser, :body
  json.url article_url(article, format: :json)
end
