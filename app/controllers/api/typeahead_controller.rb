class Api::TypeaheadController < ApplicationController
    def show
        if params[:input]
            @users = User.search(params[:input])
            render json: @users, message: "Users search result"
        end
    end
end
