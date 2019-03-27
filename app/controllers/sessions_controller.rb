class SessionsController < ApplicationController
    skip_before_action :authorized, only: [:new, :create]

    def new
        if !!current_user
            redirect_to playlists_path
        else
            render :new
        end
    end

    def create
        @user = User.find_by(dj_name: params[:dj_name])
        if @user && @user.authenticate(params[:password])
            session[:user_id] = @user.id
            redirect_to playlists_path
        else
            flash[:notice] = 'Invalid Username/Password'
            redirect_to login_path
        end
    end

    def destroy
        session.delete(:user_id)
        flash[:notice] = "You have logged out"
        redirect_to login_path
    end
    
end
