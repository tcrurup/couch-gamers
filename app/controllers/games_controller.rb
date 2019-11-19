class GamesController < ApplicationController
    
    before_action :require_login
    #User must be logged in before an actions in the game contoller are allowed to take place

    before_action :set_instance_variables, except: [:favorite]
    #@game - A game object if applicable or nil if :id not diven
    #@developer - A developer object or nil if :developer_id not given

    def create
        @game = @developer.new_game(game_params)
        current_user_can_CRUD? && @game.valid? ? (save_and_redirect_to_show(@game)) : (render :new)
    end

    def destroy  
        if current_user_can_CRUD?
            delete_game_and_redirect
        else
            flash_and_redirect_to_game("You can't delete games for #{@developer.name}") 
        end 
    end

    def favorite
        @game = Game.find_by(id: params[:id])
        @game.toggle_favorite(current_user)
        redirect_back(fallback_location: root_path)
    end

    def edit
        flash_and_redirect_to_game("You can't edit games for #{@developer.name}") unless current_user_can_CRUD?
    end
    
    def new
        @game = @developer.new_game   
        flash_and_redirect_to_developer("You can't add games for #{@developer.name}") unless current_user_can_CRUD?       
    end

    def index
        @developer ? @games = @developer.games : @games = Game.all;
    end

    def show
        flash_and_redirect_to_developer("#{@developer.name} does not have a game with that id") if @game.nil?         
    end

    def update
        @game.assign_attributes(game_params)
        @game.valid? ? (save_and_redirect_to_show(@game)) : (render :edit)
    end

    private
    def delete_game_and_redirect
        @game.destroy       
        flash_and_redirect_to_developer("#{@game.title} has been removed")
    end

    def game_params
        params.require(:game).permit(:title, :description, :release_year, :developer_id)
    end

    def flash_and_redirect_to_game(message)
        flash[:message] = message
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