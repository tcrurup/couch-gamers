class ApplicationController < ActionController::Base

    def current_user
        User.find(session[:user_id])
    end

    private

    def logged_in?
        !!current_user
    end
end
