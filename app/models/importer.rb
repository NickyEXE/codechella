class Importer

  def song_info(track)
    name = track.name
    artist = track.artists.first.name
    album = track.album.name
    url = track.external_urls.values.first
    popularity = track.popularity
    year = year_getter(track)
    image_url = image_getter(track)
    {name: name, artist: artist, album: album, url: url, popularity: popularity, year: year, image_url: image_url}
  end


  def year_getter(track)
    if track.respond_to?(:album)
      if track.album.release_date
        track.album.release_date[0..3].to_i
      end
    end
  end

  def image_getter(track)
    if track.respond_to?(:album)
      if track.album.images
        if track.album.images.first
          track.album.images.first["url"]
        end
      end
    end
  end

  def tracks_to_hash_array
    self.tracks.map do |track|
      song_info(track)
    end
  end

end
