class CommentsController < ApplicationController
  def new
    @comment = Comment.new
    @post = Post.includes(:comments, :likes).find(params[:post_id])
  end

  def create
    @comment = current_user.comments.new(comment_params)
    @comment.post_id = params[:post_id]

    respond_to do |format|
      if @comment.save
        format.html { redirect_to user_post_path(current_user, @comment.post), notice: "Comment was made successfully" }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @user = current_user
    @comment = @user.posts.find(params[:post_id]).comments.find(params[:id])
    @comment.destroy
    flash[:notice] = "Comment deleted"

    redirect_to user_post_path(@user, @comment.post)
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end
end
