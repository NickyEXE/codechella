class Importer

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

  def tracks_to_hash_array
    self.tracks.map do |track|
      song_info(track)
    end
  end

end
