json.extract! song, :id, :artist, :genre, :lyrics, :year, :created_at, :updated_at
json.url song_url(song, format: :json)
