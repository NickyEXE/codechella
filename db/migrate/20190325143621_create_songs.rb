class CreateSongs < ActiveRecord::Migration[5.2]
  def change
    create_table :songs do |t|
      t.string :artist
      t.string :lyrics
      t.integer :year

      t.timestamps
    end
  end
end
