class Playlist < ApplicationRecord
  has_many :follows
  has_many :users, through: :follows
  has_many :playlist_songs
  has_many :songs, through: :playlist_songs

end
