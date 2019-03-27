class AddUrlToPlaylists < ActiveRecord::Migration[5.2]
  def change
    add_column :playlists, :url, :string
  end
end
