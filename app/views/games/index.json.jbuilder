json.array!(@games) do |game|
  json.extract! game, :id, :user_id, :score, :progress, :completed
  json.url game_url(game, format: :json)
end
