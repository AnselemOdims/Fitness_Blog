module Api
  module V1
    class PostsController < ApplicationController
      def index
        @posts = Post.order(:created_at)
        render json: { status: 'Success', message: 'Load Posts', data: @posts }
      end
    end
  end
end
