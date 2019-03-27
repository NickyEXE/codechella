class PlaylistImporter < Importer

  attr_reader :url, :playlist_importer

  def initialize(url)
    @url = url
    playlist_link = @url.split("/")[@url.split("/").index("playlist")+1][0..21]
    @playlist_importer = RSpotify::Playlist.find("abc",playlist_link)
  end

  #accesses tracks part of the spotify pull.
  def tracks
    self.playlist_importer.tracks
  end

  #song_info and tracks_to_hash_array in importer superclass

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
