class PlaylistSongsController < ApplicationController

  def create
    
  end

  def destroy
    @playlist_add = PlaylistSong.find_by(playlist_id: params[:pid], song_id: params[:sid])
    @playlist_add.destroy
    redirect_to playlist_path(params[:pid])
  end

end
