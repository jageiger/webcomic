json.array!(@comics) do |comic|
  json.extract! comic, :id, :name, :chapters, :description
  json.url comic_url(comic, format: :json)
end
