json.array!(@pages) do |page|
  json.extract! page, :id, :image, :thumb, :description, :row_order
  json.url page_url(page, format: :json)
end
