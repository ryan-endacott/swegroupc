json.array!(@assignments) do |assignment|
  json.extract! assignment, :id, :name
  json.url assignment_url(assignment, format: :json)
end
