class ApplicationController < ActionController::Base

    def current_user
        User.find_by(id: session[:user_id])
    end

    private

    def flash_and_redirect_to_developer(message)
        flash[:message] = message
        redirect_to developer_path(@developer)
    end

    def flash_and_redirect_to_user(message)
        flash[:message] = message
        redirect_to user_path(current_user)
    end

    def flash_and_redirect_to_show_page(object, message)
        flash[:message] = message
        redirect_to :controller => object.class.table_name, :action=> 'show', :id => object.id
    end

    def flash_and_redirect_to_index_page(object, message)
        flash[:message] = message
        redirect_to :controller => object.class.table_name, :action=> 'index'
    end

    def redirect_to_current_user
        redirect_to user_path(current_user)
    end

    def require_login
        unless logged_in?
            flash[:message] = "You must be logged in to do that"
            redirect_to login_path
        end
    end

    def save_and_redirect_to_show(object)
        object.save
        redirect_to :controller => object.class.table_name, :action=> 'show', :id => object.id
    end

    def logged_in?
        !!current_user
    end
end
