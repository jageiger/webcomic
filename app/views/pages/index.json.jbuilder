json.array!(@pages) do |page|
  json.extract! page, :id, :image, :thumb, :description, :pageNum
  json.url page_url(page, format: :json)
end
