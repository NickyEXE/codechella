class User < ApplicationRecord
  has_many :follows
  has_many :playlists, through: :follows
  has_many :comments
  has_secure_password

  def songs
    self.playlists.map do |playlist|
      playlist.songs
    end.flatten
  end

  def spotify_playlist_creator(uri)
    spotify_data = PlaylistImporter.new(uri)
    playlist = self.playlists.create(name: spotify_data.name, description: spotify_data.description)
    spotify_data.playlist_importer_to_hash_array.each do |hash|
      song = Song.all.find_by(name: hash[:title], artist: hash[:artist])
      if song
        PlaylistSong.create(playlist_id: playlist.id, song_id: song.id)
      else
        playlist.songs.create(name: hash[:title], artist: hash[:artist], genre: "Need to delete this", year: hash[:year])
      end
    end
  end

end
