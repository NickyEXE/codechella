class SongsController < ApplicationController
  before_action :set_song, only: [:show, :edit, :update, :destroy]



  def show
  end

  # GET /songs/new
  def new
    @song = Song.new
    @error = flash[:error]
    flash[:playlist_id] = params[:pid]
    # byebug
  end

  # GET /songs/1/edit
  def edit
  end

  # POST /songs
  # POST /songs.json

  def create
<<<<<<< HEAD
    @playlist = Playlist.find(flash[:playlist_id])
    song = Song.find_or_create_song(artist: song_params[:artist], name: song_params[:name], playlist: @playlist)
    if song.class == Song
      redirect_to @playlist
    else
      flash[:playlist_id] = flash[:playlist_id]
      flash[:error] = "#{song_params[:name]} by #{song_params[:artist]} was not found on spotify"
      send_back_to_new_song
=======

    @song = Playlist.find(flash[:playlist_id]).songs.create(song_params)
    if @song.valid?
      redirect_to Playlist.find(flash[:playlist_id])
    else
      redirect_to new_song_path(playlist_id: flash[:playlist_id])
>>>>>>> master
    end
  end
  # def create
  #   @playlist = Playlist.find(flash[:playlist_id])
  #   @song = Song.find_by(name: song_params[:name], artist: song_params[:artist])
  #   if @song
  #     PlaylistSong.create(playlist_id: @playlist.id, song_id: @song.id)
  #     redirect_to @playlist
  #   else
  #     @songdata = SongImporter.new(name: song_params[:name], artist: song_params[:artist])
  #     if @songdata.import_data.length > 0
  #       @songdatahash = @songdata.song_data_to_hash
  #       if @songdatahash
  #         @song = @playlist.songs.create(@songdatahash)
  #         if @song.valid?
  #           redirect_to @playlist
  #         else
  #           flash[:errors] = @song.errors
  #           send_back_to_new_song
  #         end
  #       else
  #         flash[:errors] = ["There is no song named #{song_params[:name]} by #{song_params[:artist]} on Spotify."]
  #         send_back_to_new_song
  #       end
  #     else
  #       flash[:errors] = @song.errors
  #       send_back_to_new_song
  #     end
  #   end
  # end

  # PATCH/PUT /songs/1
  # PATCH/PUT /songs/1.json
  def update
    respond_to do |format|
      if @song.update(song_params)
        format.html { redirect_to @song, notice: 'Song was successfully updated.' }
        format.json { render :show, status: :ok, location: @song }
      else
        format.html { render :edit }
        format.json { render json: @song.errors, status: :unprocessable_entity }
      end
    end
  end


  # DELETE /songs/1
  # DELETE /songs/1.json
  def destroy
    @song.destroy
    respond_to do |format|
      format.html { redirect_to songs_url, notice: 'Song was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_song
      @song = Song.find(params[:sid])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def song_params
      params.require(:song).permit(:name, :artist)
    end

    def send_back_to_new_song
      redirect_to new_song_path(playlist_id: @playlist.id)
    end
end
