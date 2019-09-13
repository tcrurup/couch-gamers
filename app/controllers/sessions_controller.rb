class SessionsController < ApplicationController

    def new
        redirect_to user_path(current_user) if logged_in?        
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