class PlaylistImporter

  attr_reader :url, :playlist_importer

  def initialize(url)
    @url = url
    playlist_link = @url.split("/")[@url.split("/").index("playlist")+1][0..21]
    @playlist_importer = RSpotify::Playlist.find("abc",playlist_link)
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
