class UsersController < ApplicationController

    def create
        @user = User.create(user_params)
        redirect_to user_path(@user)
    end
    
    def new
        @user = User.new
    end

    def show
        @user = User.find(params[:id])
    end

    private



    def user_params
        params.require(:user).permit(:username, :password, :first_name, :last_name)
    end
end