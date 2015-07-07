json.array!(@questions) do |question|
  json.extract! question, :id, :lat, :long, :difficulty, :attempts, :correct
  json.url question_url(question, format: :json)
end
