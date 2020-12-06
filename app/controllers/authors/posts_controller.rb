
module Authors
  class PostsController < AuthorsController
    before_action :set_post, only: [:edit, :update, :destroy, :publish, :unpublish, :like, :finish]
    
  
    # GET /posts
    def index
      if current_author.is_admin?
        @posts = Post.all.order(published: :asc)
      else
        @posts = current_author.posts.order(published: :asc)
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
      @tags = Tag.all
    end
  
    # GET /posts/1/edit
    def edit
      @elements = @post.elements.order(position: :asc)
      @element = @post.elements.build
      @tags = Tag.all
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
      redirect_to posts_path, notice: 'Post Eliminidado'
    end
    
    def publish
      if current_author.is_admin?
        @post.update(published: true, published_at: Time.now)
        redirect_to posts_path
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
      @user = current_author
      admin = Author.first
      require 'sendgrid-ruby'

      from = SendGrid::Email.new(email: 'maria@ifixmii.com')
      to = SendGrid::Email.new(email: 'mar.alvareg@gmail.com')
      subject = 'Sending with Twilio SendGrid is Fun'
      content = SendGrid::Content.new(type: 'text/plain', value: 'and easy to do anywhere, even with Ruby')
      mail = SendGrid::Mail.new(from, subject, to, content)

      sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])
      response = sg.client.mail._('send').post(request_body: mail.to_json)
      puts response.status_code
      puts response.body
      puts response.parsed_body
      puts response.headers
      redirect_to posts_path
    end

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
        if current_author.is_admin?
          @post = Post.friendly.find(params[:id])
        else
          @post = current_author.posts.friendly.find(params[:id])
        end
      end
  
      # Only allow a trusted parameter "white list" through.
      def post_params
        params.require(:post).permit(:title, :header_image, :tag_id)
      end
  end  
end

