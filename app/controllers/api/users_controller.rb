class Api::UsersController < ApplicationController

    def index
        @users = User.all.order("created_at DESC")
        render :json => { "message" => "Users list", "success" => true, "users" => @users }
    end

    def show
        @user = User.find(params[:id])
        if @user.nil?
            @user = []
        end
        render json: @user
    end

    def create
        @user = User.new(user_params)
    
        if @user.save
            render :json => { "message" => "User created successfully.", "success" => true, "user" => @user }
        else
            render json: @user.errors, status: :unprocessable_entity
        end
    end

    def update
        @user = User.find(params[:id])
        if @user.present?
            if @user.update(user_params)
                render :json => { "message" => "User updated successfully.", "success" => true, "user" => @user }
            else
                render json: @user.errors, status: :unprocessable_entity
            end
        else
            render :json => { "message" => "User not found to update the record", "success" => false }
        end
    end

    def destroy
        @user = User.find(params[:id])
        if @user.present?
            @user.destroy
            render :json => { "message" => "User deleted successfully.", "success" => true }
        else
            render :json => { "message" => "User not found to delete the record", "success" => false }
        end
    end

    private
    
    def user_params
        params.require(:user).permit(:firstName, :lastName, :email)
    end

end
