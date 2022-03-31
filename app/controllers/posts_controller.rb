class PostsController < ApplicationController
  def index
    @posts = Post.includes(:comments, :likes).where(author_id: params[:user_id])
  end

  def show
    @post = Post.includes(:comments, :likes).find(params[:id])
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.new(post_params)

    respond_to do |format|
      if @post.save
        flash[:success] = 'Post was created successfully'
        format.html { redirect_to user_posts_url(current_user) }
      else
        flash.now[:error] = 'Ooops!!! Something went wrong'
        format.html { render :new }
      end
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
