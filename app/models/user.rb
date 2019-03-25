class User < ApplicationRecord
  has_many :follows
  has_many :playlists, through: :follows

  def songs
    self.playlists.map do |playlist|
      playlist.songs
    end.flatten
  end
end
