class PostsController < ApplicationController

  def new
    @post = Post.new
    @user = current_user
  end

  def create
    @post = Post.new(post_params)
    @post.update(user_id: current_user.id)
    if @post.valid?
      redirect_to posts_path
    else
      @errors = @post.errors.full_messages
      render :new
    end
  end

  def index
    @errors = flash[:errors]
    @comment = Comment.new
    @posts = Post.last_x_posts(50)
    @users = User.all
    render :index
  end

  def edit
    set_post
    @user = current_user
    render :edit
  end

  def update
    set_post
    @post.update(post_params)
    if @post.valid?
      redirect_to posts_path
    else
      @errors = @post.errors.full_messages
      render :edit
    end
  end

  def destroy
    set_post
    @post.destroy
    redirect_to posts_path
  end

  private

  def post_params
    params.require(:post).permit(:playlist_id, :title, :description)
  end

  def set_post
    @post = Post.find(params[:id])
  end

end
