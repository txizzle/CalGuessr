json.array!(@questions) do |question|
  json.extract! question, :id, :lat, :long, :difficulty, :attempts, :rating
  json.url question_url(question, format: :json)
end
