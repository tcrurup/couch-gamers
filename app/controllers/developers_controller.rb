class DevelopersController < ApplicationController

    def create
        @developer = current_user.new_developer(developer_params)
        @developer.save ? (redirect_to developer_path(@developer)) : (render :new)
    end

    def edit
        set_developer_by_id
    end

    def index
        @developers = Developer.all
    end

    def new
        @developer = current_user.new_developer 
    end  

    def show
        set_developer_by_id
    end

    private

    def developer_params
        params.require(:developer).permit(:name)
    end

    def set_developer_by_id
        @developer = Developer.find_by(id: params[:id])
    end

end