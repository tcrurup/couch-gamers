class DevelopersController < ApplicationController

    def create
        @developer = Developer.new(developer_params)
        if @developer.valid?
            @developer.save
            redirect_to developer_path(@developer)
        else
            render :new
        end
    end

    def new
        @developer = Developer.new
    end

    def show
        @developer = Developer.find_by(id: params[:id])
    end

    private

    def developer_params
        params.require(:developer).permit(:name)
    end
end