class Song < ApplicationRecord
  has_many :playlist_songs
  has_many :playlists, through: :playlist_songs

  def new_lyrics
    if self.artist && self.name
      begin
        url = URI.escape("https://api.lyrics.ovh/v1/#{self.artist.downcase}/#{self.name.downcase}")
        response = RestClient.get url
      rescue RestClient::ExceptionWithResponse => e
        if e.class == RestClient::NotFound
          "I'm sorry, it looks like we don't have lyrics available for #{self.artist}'s #{self.name}'"
        end
      end
      if response
        JSON.parse(response)["lyrics"]
      end
    else
      "This program needs both a song name and a song title to render its lyrics."
    end
  end
  #Spotify API Stuff

  


end
