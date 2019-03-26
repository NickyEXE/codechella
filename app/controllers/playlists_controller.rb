class PlaylistsController < ApplicationController
  before_action :set_playlist, only: [:show, :edit, :update, :destroy]

  # GET /playlists
  # GET /playlists.json
  def index
    @playlists = current_user.playlists
  end

  # GET /playlists/1
  # GET /playlists/1.json

  def find_new_playlists
    @playlists = Playlist.all
    render :find_new_playlists
  end

  def show
    @songs = @playlist.songs
  end

  # GET /playlists/new
  def new
    @users = User.all
    @playlist = Playlist.new
    render :new
  end

  # GET /playlists/1/edit
  def edit
    if current_user == @playlist.original_author
      render :edit
    else
      redirect_to playlists_path
    end
  end

  # POST /playlists
  # POST /playlists.json
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

  # PATCH/PUT /playlists/1
  # PATCH/PUT /playlists/1.json
  def update
    if @playlist.update(playlist_params)
      redirect_to @playlist
    else
      @errors = @playlist.errors.full_messages
      render :edit
    end
  end

  # DELETE /playlists/1
  # DELETE /playlists/1.json
  def destroy
    @playlist.destroy
    respond_to do |format|
      format.html { redirect_to playlists_url, notice: 'Playlist was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_playlist
      @playlist = Playlist.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def playlist_params
      params.require(:playlist).permit(:name, :description, :author_id)
    end
end
