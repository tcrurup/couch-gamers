class SessionsController < ApplicationController

    def new

    end

    def create
        @user = User.find_by(username: params[:username])
        session[:user_id] = @user.id
        redirect_to user_path (@user)
    end

    def delete
        session.delete :user_id
    end
end