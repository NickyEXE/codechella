class Playlist < ApplicationRecord
  has_many :follows, dependent: :destroy
  has_many :users, through: :follows
  has_many :playlist_songs, dependent: :destroy
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

  def song_for_image
    self.songs.find do |song|
      song.image_url
    end
  end

  def self.sort_by_popularity
    self.all.sort_by do |playlist|
      playlist.follows.length
    end.reverse
  end

  def top_x_playlists(x)
    self.sort_by_popularity[0..x].map do |playlist|
      [playlist.name, playlist.original_author_dj_name, playlist.follows.length]
    end
  end
end

  # def image
  #   song = self.song_for_image
  #   if song
  #     song.image_url
  #   else
  #     image_url('logo.png')
  #   end
  # end
