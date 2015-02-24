json.array!(@comics) do |comic|
  json.extract! comic, :id, :title, :num_chapters, :description
  json.url comic_url(comic, format: :json)
end
