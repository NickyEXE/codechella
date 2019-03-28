class PlaylistImporter < Importer

  attr_reader :url, :import_data

  def initialize(url)
    @url = url
    playlist_link = @url.split("/")[@url.split("/").index("playlist")+1][0..21]
    @import_data = RSpotify::Playlist.find("abc",playlist_link)
  end

  #accesses tracks part of the spotify pull.
  def tracks
    self.import_data.tracks
  end

  #song_info and tracks_to_hash_array in importer superclass

  def name
    clean_string(self.import_data.name)
  end

  def description
    description = self.import_data.description
    if description == ""
      "No description on spotify."
    else
      clean_string(description)
    end
  end

  def clean_string(string)
    string.gsub(/&#x27;/,"'")
  end

  def open_url
    "https://open.spotify.com/"+self.import_data.path
  end

end
