json.array!(@pages) do |page|
  json.extract! page, :id, :image, :thumb, :description, :number
  json.url page_url(page, format: :json)
end
