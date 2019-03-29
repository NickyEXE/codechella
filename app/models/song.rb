class Song < ApplicationRecord
  has_many :playlist_songs, dependent: :destroy
  has_many :playlists, through: :playlist_songs
  validates :artist, presence: true
  validates :name, presence: true

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

  def self.find_song(artist:, name:, playlist:)
    Song.find_by(name: name, artist: artist)
  end

  def self.create_song(artist:, name:, playlist:)
    song = playlist.songs.new(artist: artist, name: name)
    if song.valid?
      song.create_song_on_spotify(playlist)
    end
  end

  def create_song_on_spotify(playlist)
    song_data = SongImporter.new(name: self.name, artist: self.artist)
    song_data_hash = song_data.song_data_to_hash
    if song_data_hash
      playlist.songs.create(song_data_hash)
    end
  end

  def self.find_or_create_song(artist:, name:, playlist:)
    song = self.find_song(artist: artist, name: name, playlist: playlist)
    if song.class == Song
      PlaylistSong.create(playlist_id: playlist.id, song_id: song.id)
      song
    else
      self.create_song(artist: artist, name: name, playlist: playlist)
    end
  end

  #Spotify API Stuff




end
