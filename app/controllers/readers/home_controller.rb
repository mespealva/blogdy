module Readers
  class HomeController < ReadersController
    def index
      @posts = Post.where.not(tag_id: 3).published.most_recently_published
    end

    def team
      @posts = Post.published.where(tag_id: 3)
    end

    def research 
      @posts = Post.published.where(tag_id: 1).most_recently_published
    end

    def opinion
      @posts = Post.published.where(tag_id: 2).most_recently_published
    end

    def mujeres
      @posts = Post.published.where(tag_id: 4).most_recently_published
    end

    def difusion
      @posts = Post.published.where(tag_id: 5).most_recently_published
    end
  end
end