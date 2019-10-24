class GamesController < ApplicationController
    
    #User must be logged in before an actions in the game contoller are allowed to take place
    before_action :require_login
    before_action :set_instance_variables




    def create
        @game = @developer.new_game(game_params)
        current_user_can_CRUD? && @game.valid? ? (save_game_and_redirect) : (render :new)
    end

    def destroy  
        current_user_can_CRUD? ? (delete_game_and_redirect) : (redirect_to user_path(current_user))    
    end

    def edit
        redirect_to developer_game_path(@developer, @game) unless current_user_can_CRUD?
    end
    
    def new
        @game = Game.new(developer_id: @developer.id)
        redirect_to developer_path(@developer) unless current_user_can_CRUD?  
    end

    def index
        @developer ? @games = @developer.games : @games = Game.all;
    end

    def show
        flash_and_redirect_to_show_page(@developer,"#{@developer.name} does not have a game with that id") if @game.nil?         
    end

    def update
        @game.assign_attributes(game_params)
        @game.valid? ? (save_game_and_redirect) : (render :edit)
    end

    private
    def delete_game_and_redirect_to_developer
        @game.destroy       
        flash_and_redirect_to_show_page(@game.developer,"#{@game.title} has been removed")
    end

    def developer_owns_game
        @developer.owns_game?(@game)
    end

    def game_params
        params.require(:game).permit(:title, :description, :release_year, :developer_id)
    end

    def redirect_to_developer_through_game(game)
        redirect_to developer_game_path(game.developer, game) 
    end

    def save_game_and_redirect
        @game.save
        redirect_to developer_game_path(@game.developer, @game)
    end

    def set_instance_variables
        @developer = Developer.find_by(id: params[:developer_id])
        if params[:id]
            @game = @developer.games.find_by(id: params[:id])
        end
    end

    def current_user_can_CRUD?
        #User can CRUD a game if the are an employee for the developer
        @game.user_has_permission_to_CRUD?(current_user)
    end

end