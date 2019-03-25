json.extract! playlist, :id, :name, :description, :author_id, :created_at, :updated_at
json.url playlist_url(playlist, format: :json)
