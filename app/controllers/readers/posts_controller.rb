module Readers
    class PostsController < ReadersController
      impressionist
  
      def show
        @post = Post.published.friendly.find(params[:id])
        impressionist(@post)
      end
      
    end
  end