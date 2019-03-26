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

end
