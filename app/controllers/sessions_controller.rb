class SessionsController < ApplicationController

    def new
        if logged_in?
            message = "You must log out of this account before signing in"
            flash_and_redirect_to_show_page(current_user, message) 
        end        
    end

    def create
        @user = User.find_by(username: params[:username])
        session[:user_id] = @user.id
        redirect_to user_path (@user)
    end

    def delete
        session.delete :user_id
        redirect_to login_path
    end

    
end