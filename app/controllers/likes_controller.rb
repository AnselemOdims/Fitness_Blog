class LikesController < ApplicationController
  before_action :authenticate_user!

  def create
    @post = Post.find(params[:post_id])
    @like = current_user.likes.new(post_id: @post.id)

    respond_to do |format|
      if @like.save
        format.html { redirect_to user_post_path(current_user, @post), notice: 'Like was successful' }
      else
        flash[:error] = 'Like was not successful'
        format.html { redirect_to @post }
      end
    end
  end
end
