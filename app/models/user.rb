class User < ApplicationRecord
  has_many :follows, dependent: :destroy
  has_many :playlists, through: :follows
  has_many :comments, dependent: :destroy
  validates :dj_name, uniqueness: true
  has_secure_password

  def songs
    self.playlists.map do |playlist|
      playlist.songs
    end.flatten
  end

  def spotify_playlist_creator(spotify_data)
    playlist = self.playlists.create(name: spotify_data.name, description: spotify_data.description, url: spotify_data.open_url)
    spotify_data.tracks_to_hash_array.each do |hash|
      song = Song.all.find_by(name: hash[:title], artist: hash[:artist])
      if song
        PlaylistSong.create(playlist_id: playlist.id, song_id: song.id)
      else
        #playlist.songs.create(name: hash[:title], artist: hash[:artist], year: hash[:year])
        playlist.songs.create(hash)
      end
    end
  end

end
