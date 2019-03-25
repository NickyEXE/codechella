class RemoveAuthorIdFromPlaylists < ActiveRecord::Migration[5.2]
  def change
    remove_column :playlists, :author_id
  end
end
