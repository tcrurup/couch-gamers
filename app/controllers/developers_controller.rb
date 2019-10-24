class DevelopersController < ApplicationController

    def create
        @developer = Developer.new(developer_params)
        @developer.save ? (redirect_to developer_path(@developer)) : (render :new)
    end

    def new
        @developer = Developer.new
        @developer.owner = current_user
    end

    def index
        @developers = Developer.all
    end

    def show
        @developer = Developer.find_by(id: params[:id])
    end

    private

    def developer_params
        params.require(:developer).permit(:name)
    end

end