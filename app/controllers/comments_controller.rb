class CommentsController < ApplicationController


  def create
    @comment = Comment.new(comment_params)
    @comment.update(user_id: current_user.id)
    if @comment.save
      redirect_to posts_path
    else
      @errors = @comment.errors.full_messages
      @posts = Post.last_x_posts(50)
      @users = User.all
      flash[:errors] = @errors
      redirect_to posts_path
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:post_id, :comment_text)
  end

end
