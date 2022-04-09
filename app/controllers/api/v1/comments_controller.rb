module Api
  module V1
    class CommentsController < ApplicationController
      def index
        post_id = params[:post_id]
        @comments = Comment.where({ post_id: post_id }).order(:created_at)
        render json: { status: 'Success', message: 'Comments Loaded', data: @comments }
      end

      def create
        @post = Post.find(params[:post_id])
        @comment = @post.comments.new(text: comment_params, author_id: current_user.id)

        if @comment.save
          render json: { success: 'Success', message: 'Comment Added Successfully', data: @comment }, status: :created
        else
          render json: { success: 'failed', errors: @comment.errors }, status: :bad_request
        end
      rescue ActiveRecord::RecordNotFound
        flash[:notice] = "We couldn't find that Post."
      end

      private

      def comment_params
        params.require(:comment).permit(:text)
      end
    end
  end
end
