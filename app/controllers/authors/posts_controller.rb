module Authors
  class PostsController < AuthorsController
    before_action :set_post, only: [:edit, :update, :destroy, :publish, :unpublish, :finish, :like]
    
  
    # GET /posts
    def index
      if current_author.is_admin?
        @posts = Post.all
      else
        @posts = current_author.posts
      end 
    end
    
    def posted
      @posts = current_author.posts.where(published: true)
    end
    
    def unposted
      @posts = current_author.posts.where(published: false)
    end 
  
    def finished
      @posts = Post.where(finished: true)
    end


    # GET /posts/new
    def new
      @post = current_author.posts.build
    end
  
    # GET /posts/1/edit
    def edit
      @elements = @post.elements.order(position: :asc)
      @element = @post.elements.build
    end
  
    # POST /posts
    def create
      @post = current_author.posts.build(post_params)
  
      if @post.save
        redirect_to edit_post_path(@post)
      else
        broadcast_errors @post, post_params
      end
    end
  
    # PATCH/PUT /posts/1
    def update
      if @post.update(post_params)
        redirect_to edit_post_path(@post)
      else
        broadcast_errors @post, post_params
      end
    end
  
    # DELETE /posts/1
    def destroy
      @post.destroy
      redirect_to posts_url, notice: 'Post was successfully destroyed.'
    end
    
    def publish
      if current_author.is_admin?
        @post.update(published: true, published_at: Time.now)
        redirect_to edit_post_path(@post)
      end
    end

    def unpublish
      if current_author.is_admin?
        @post.update(published: false, published_at: nil)
        redirect_to edit_post_path(@post)
      end
    end

    def finish
      @post.update(finished: true)
      redirect_to edit_post_path(@post)
      
      send_simple_message
      #email = mail from: '<mar.alvareg@gmail.com>', to: user, subject: 'hay un borrador terminado'
    end

    # def send_simple_message
    #   user = Author.first.email
    #   RestClient.post ENV["APIMAIL"]\
    #   ENV["APIENV"],
    #   from: "Excited User <mailgun@YOUR_DOMAIN_NAME>",
    #   to: "mar.alvareg@gmail.com, YOU@YOUR_DOMAIN_NAME",
    #   subject: "Hello",
    #   text: "Testing some Mailgun awesomness!"
    # end
    
    def like
      if current_author.voted_for? @post
        @post.unliked_by current_author
      else
        @post.liked_by current_author
      end
    end
    private
      # Use callbacks to share common setup or constraints between actions.
      def set_post
        @post = Post.friendly.find(params[:id])
      end
  
      # Only allow a trusted parameter "white list" through.
      def post_params
        params.require(:post).permit(:title, :header_image)
      end
  end  
end

