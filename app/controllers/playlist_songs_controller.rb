class PlaylistSongsController < ApplicationController

  def destroy
    @playlist_add = PlaylistSong.find_by(playlist_id: params[:pid], song_id: params[:sid]).destroy
    redirect_to playlist_path(params[:pid])
  end

end
