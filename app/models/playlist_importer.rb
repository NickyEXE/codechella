class PlaylistImporter

  attr_reader :uri, :playlist_importer

  def initialize(uri)
    @uri = uri
    uri_array = @uri.split(":")
    @playlist_importer = RSpotify::Playlist.find(uri_array[2],uri_array[4])
  end

  def song_info(track)
    name = track.name
    artist = track.artists.first.name
    album = track.album.name
    url = track.external_urls.values.first
    popularity = track.popularity
    year = track.album.release_date[0..3].to_i
    image_url = track.album.images.first["url"]
    {name: name, artist: artist, album: album, url: url, popularity: popularity, year: year, image_url: image_url}
  end

  def playlist_importer_to_hash_array
    self.playlist_importer.tracks.map do |track|
      song_info(track)
    end
  end

  def name
    clean_string(self.playlist_importer.name)
  end

  def description
    description = self.playlist_importer.description
    if description == ""
      "No description on spotify."
    else
      clean_string(description)
    end
  end

  def clean_string(string)
    string.gsub(/&#x27;/,"'")
  end

end
