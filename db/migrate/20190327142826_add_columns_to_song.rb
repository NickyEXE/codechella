class AddColumnsToSong < ActiveRecord::Migration[5.2]
  def change
    add_column :songs, :album, :string
    add_column :songs, :url, :string
    add_column :songs, :popularity, :integer
    add_column :songs, :image_url, :string
  end
end
