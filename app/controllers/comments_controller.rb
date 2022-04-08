class CommentsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  def new
    @comment = Comment.new
    @post = Post.includes(:comments, :likes).find(params[:post_id])
  end

  def create
    @comment = current_user.comments.new(comment_params)
    @comment.post_id = params[:post_id]

    respond_to do |format|
      if @comment.save
        format.html { redirect_to user_post_path(current_user, @comment.post), notice: 'Comment was made successfully' }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @comment = Comment.find_by(post_id: params[:post_id])
    authorize! :destroy, @comment
    @comment.destroy
    flash[:notice] = 'Comment deleted successfully'
    redirect_to user_post_path(@comment.author, @comment.post)
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end
end
