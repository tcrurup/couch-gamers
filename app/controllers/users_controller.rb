class UsersController < ApplicationController

    def create
        @user = User.new(user_params)

        if @user.valid?
            @user.save
            redirect_to user_path(@user)
        else
            render :new
        end
    end
    
    def new
        @user = User.new
    end

    def show
        @user = User.find(params[:id])
    end

    private

    def user_params
        params.require(:user).permit(:username, :password, :first_name, :last_name, :email)
    end
end