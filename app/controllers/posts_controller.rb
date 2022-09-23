class PostsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @posts = Post.where(author_id: params[:user_id])
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.new(post_params)
    respond_to do |format|
      format.html do
        if @post.save
          redirect_to "/users/#{@post.author.id}/posts/#{@post.id}"
        else
          render :new
        end
      end
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :text, :likes_counter, :comments_counter)
  end
end
