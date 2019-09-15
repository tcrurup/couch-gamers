class SessionsController < ApplicationController

    def new
        if logged_in?
            message = "You must log out of this account before signing in"
            flash_and_redirect_to_show_page(current_user, message) 
        end        
    end

    def create
        if auth
            @user = User.find_or_create_by(uid: auth['uid']) do |u|
                u.full_name = auth['info']['name']
                u.username = u.full_name.parameterize.underscore
                u.password = random_password
                u.email = auth['info']['email']
                u.image = auth['info']['image']
            end
            session[:user_id] = @user.id
            redirect_to user_path (@user)            
        else
            @user = User.find_by(username: params[:username])
            if @user && @user.authenticate(params[:password])
                session[:user_id] = @user.id
                redirect_to user_path (@user)
            else
                render :new
            end
        end
    end

    def delete
        session.delete :user_id
        redirect_to login_path
    end

    private 

    def auth 
        request.env['omniauth.auth']
    end

    
    def random_password(length=10)
        possible_chars = ('0'..'9').to_a + ('A'..'Z').to_a + ('a'..'z').to_a
        possible_chars.shuffle.join[0...length]
    end

    
end