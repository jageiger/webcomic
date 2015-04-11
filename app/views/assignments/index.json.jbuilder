json.array!(@assignments) do |assignment|
  json.extract! assignment, :id, :user_id, :comic_id, :role
  json.url assignment_url(assignment, format: :json)
end
