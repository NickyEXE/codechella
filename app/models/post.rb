class Post < ApplicationRecord
  belongs_to :user
  belongs_to :playlist
  has_many :comments
  
  validates :title, presence: true

  #selects the last x posts to render in the post view
  def self.last_x_posts(num)
    Post.all.order(created_at: :desc).limit(num)
  end
end
