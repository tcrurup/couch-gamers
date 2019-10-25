class DevelopersController < ApplicationController

    before_action :set_developer_by_id, only: [:destroy, :edit, :show, :update]

    before_action :verify_current_user_owns_developer, only: [:destroy, :edit, :update]


    def create
        @developer = current_user.new_developer(developer_params)
        @developer.valid? ? (save_and_redirect_to_show(@developer)) : (render :new)
    end

    def destroy
        @developer.destroy
        @developer.games.each do |game|
            game.destroy
        end
        flash_and_redirect_to_user("#{@developer.name} has been deleted")
    end

    def edit
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

    def verify_current_user_owns_developer
        flash_and_redirect_to_developer("Only the owner can make changes to #{@developer.name}") unless @developer.owner === current_user
    end


end