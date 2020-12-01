class AuthorsController < ApplicationController
    before_action :authenticate_author!

    def is_admin?
        if current_author.id=1
            return true
        end
    end
end
