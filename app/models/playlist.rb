class Playlist < ApplicationRecord
  has_many :follows
  has_many :users, through: :follows
  has_many :playlist_songs
  has_many :songs, through: :playlist_songs

  def original_author
    User.find(Follow.all.where(playlist_id: self.id).order(:created_at).first.user_id)
  end

  def original_author_dj_name
    self.original_author.dj_name
  end

end
