
module Authors
  class UsersController < AuthorsController
    before_action :set_author, only: :destroy
    def index
      @authors = Author.all
    end

    def destroy
      @author.destroy
    end

    private
    def set_author
      @author = Author.find(params[:format])
    end
  end
end

