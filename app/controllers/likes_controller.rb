class LikesController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @like = current_user.likes.new(post_id: @post.id)

    respond_to do |format|
      if @like.save
        format.html { redirect_to user_post_path(current_user, @post) }
      else
        format.html { redirect_to @post }
      end
    end
  end
end
