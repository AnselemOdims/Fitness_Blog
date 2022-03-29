class PostsController < ApplicationController
  def index
    @posts = Post.where(author_id: params[:user_id])
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
  end

  def create
    @post = @current_user.posts.new(post_params)

    respond_to do |format|
      if @post.save
        flash[:success] = 'Post created successfully'
        format.html { redirect_to @post }
      else
        flash.now[:error] = 'Ooops! Post could not be saved'
        format.html { render :new }
      end
    end
  end
end
