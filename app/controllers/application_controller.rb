class ApplicationController < ActionController::Base

    def current_user
        User.find_by(id: session[:user_id])
    end

    private

    def flash_and_redirect_to_show_page(object, message)
        flash[:message] = message
        redirect_to :controller => object.class.name.downcase.pluralize, :action=> 'show', :id => object.id
    end

    def logged_in?
        !!current_user
    end
end
