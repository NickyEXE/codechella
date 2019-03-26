class FollowsController < ApplicationController

  def create
    follow = Follow.create(user_id: current_user.id, playlist_id: params[:pid])
    redirect_to '/playlists/'
  end


  def destroy
    Follow.find_by(playlist_id: params[:pid], user_id: current_user).destroy
    redirect_to '/playlists/'
  end

end
