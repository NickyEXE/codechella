class SongImporter < Importer
  attr_reader :name, :artist, :import_data

  def initialize(name:, artist:)
    @name = name
    @artist = artist
    @import_data = RSpotify::Track.search(@name)
  end


  def select_song_with_correct_artist
    self.import_data.select do |track|
      track.artists.first.name == self.artist
    end.first
  end

  def song_data_to_hash
    song = self.select_song_with_correct_artist
    if song
      song_info(song)
    end
  end


end
