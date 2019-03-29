class PlaylistsController < ApplicationController
  before_action :set_playlist, only: [:show, :edit, :update, :destroy]

  def index
    @playlists = current_user.playlists
  end

  def find_new_playlists
    @playlists = Playlist.all
    render :find_new_playlists
  end

  def find_popular_playlists
    @playlists = Playlist.all.sort_by_popularity[0..14]
    render :most_popular_playlists
  end


  def new_spotify_playlist
    @error = flash[:error]
    render :spotify_new
  end

  def add_spotify_playlist
    if (params[:url]).class == String && (params[:url]).length >0 && (params[:url]).index("/")
      begin
        spotify_data = PlaylistImporter.new(params[:url])
      rescue RestClient::ExceptionWithResponse => e
      end
      if spotify_data
        current_user.spotify_playlist_creator(spotify_data)
        redirect_to playlists_path
      else
        flash[:error] = "Error: Invalid Playlist Link"
        redirect_to add_spotify_playlist_path
      end
    else
      flash[:error] = "Error: Please add a valid link."
      redirect_to add_spotify_playlist_path
    end
  end

  def show
    @songs = @playlist.songs
    @permission = @playlist.permission_to_edit?(current_user) && @playlist.permission_to_delete?(current_user)
  end

  def new
    @users = User.all
    @playlist = Playlist.new
    render :new
  end

  def edit
    if current_user == @playlist.original_author
      render :edit
    else
      redirect_to playlists_path
    end
  end

  def create
    @playlist = current_user.playlists.create(playlist_params)

    respond_to do |format|
      if @playlist.save
        format.html { redirect_to @playlist, notice: 'Playlist was successfully created.' }
        format.json { render :show, status: :created, location: @playlist }
      else
        format.html { render :new }
        format.json { render json: @playlist.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    if @playlist.update(playlist_params)
      redirect_to @playlist
    else
      @errors = @playlist.errors.full_messages
      render :edit
    end
  end

  def destroy
    @playlist.destroy
    respond_to do |format|
      format.html { redirect_to playlists_url, notice: 'Playlist was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_playlist
      @playlist = Playlist.find(params[:id])
    end

    def playlist_params
      params.require(:playlist).permit(:name, :description, :author_id)
    end

end
