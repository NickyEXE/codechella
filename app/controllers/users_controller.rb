class UsersController < ApplicationController
  skip_before_action :authorized, only: [:new, :create]
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def show
    if @user.id != current_user.id
      redirect_to "/users/#{current_user.id}"
    else
      render :show
    end
  end

  def new
    if !!current_user
      redirect_to playlists_path
    else
      @user = User.new
      render :new
    end
  end

  def edit
    if @user.id != current_user.id
      redirect_to "/users/#{current_user.id}/edit"
    else
      render :edit
    end
  end

  def create
    @user = User.create(user_params)
    session[:user_id] = @user.id
    redirect_to :controller => "playlists", :action => "index"
  end

  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:dj_name, :password)
    end
end
