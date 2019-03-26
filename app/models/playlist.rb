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

  def does_user_follow?(current_user)
    !!self.follows.find_by(user_id: current_user.id)
  end

  def permission_to_edit?(current_user)
    self.original_author == current_user
  end

  def permission_to_delete?(current_user)
    self.original_author == current_user
  end


end
