class CommentsController < ApplicationController
  def new
    @post = Post.includes(:comments, :likes).find(params[:post_id])
    @comment = Comment.new
  end

  def create
    @comment = current_user.comments.new(comment_params)
    @comment.post_id = params[:post_id]

    respond_to do |format|
      if @comment.save
        flash.now[:success] = 'Comment was made successfully'
        format.html { redirect_to user_post_path(current_user, @comment.post) }
      else
        flash.now[:error] = 'Comment could not be saved'
        format.html { render :new }
      end
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end
end
