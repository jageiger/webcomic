json.array!(@chapters) do |chapter|
  json.extract! chapter, :id, :title, :description, :num_pages
  json.url chapter_url(chapter, format: :json)
end
