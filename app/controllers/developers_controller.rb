class DevelopersController < ApplicationController

    before_action :set_developer_by_id, only: [:edit, :show, :update]


    def create
        @developer = current_user.new_developer(developer_params)
        @developer.valid? ? (save_and_redirect_to_show(@developer)) : (render :new)
    end

    def edit
        flash_and_redirect_to_developer("Only the owner can make changes to #{@developer.name}") unless @developer.owner === current_user
    end

    def index
        @developers = Developer.all
    end

    def new
        @developer = current_user.new_developer 
    end  

    def show
    end

    def update
        @developer.assign_attributes(developer_params)
        @developer.valid? ? (save_and_redirect_to_show(@developer)) : (render :edit)
    end

    private

    def developer_params
        params.require(:developer).permit(:name)
    end

    def set_developer_by_id
        @developer = Developer.find_by(id: params[:id])
    end


end