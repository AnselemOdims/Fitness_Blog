module Api
  module V1
    class CommentsController < ApplicationController
      def index
      post_id = params[:post_id]
      @comments = Comment.where({ post_id: post_id }).order(:created_at)
      render json: { status: "Success", message: "Comments Loaded", data: @comments }
      end
    end
  end
end