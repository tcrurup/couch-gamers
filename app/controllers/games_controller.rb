class GamesController < ApplicationController
    
    #User must be logged in before an actions in the game contoller are allowed to take place
    before_action :require_login
    before_action :set_developer_by_id, :except => [:edit]
    before_action :set_game_by_id, :only => [:destroy, :edit, :update]



    def create
        @game = @developer.new_game(game_params)
        
        if current_user_can_CRUD? && @game.valid?
            save_game_and_redirect
        else
            render :new
        end
    end

    def destroy  
        if current_user_can_CRUD? 
            delete_game 
        else 
            redirect_to user_path(current_user)
        end       
    end

    def edit
        render :show unless current_user_can_CRUD?
    end
    
    def new
        @game = Game.new(developer_id: @developer.id)
        render "developers/show" unless current_user_can_CRUD?  
    end

    def index
        @developer ? @games = @developer.games : @games = Game.all;
    end

    def show
        @game = @developer.games.find_by(id: params[:id])
        if @game.nil? 
            message = "#{@developer.name} does not have a game with that id"
            flash_and_redirect_to_show_page(@developer, message)
        end                
    end

    def update
        @game.update(game_params)

        if @game.valid?
            redirect_to developer_game_path(@game.developer, @game)
        else
            render :edit
        end
    end

    private
    def current_user_employed_at_developer
        @developer.has_employee?(current_user)
    end 

    def delete_game_and_redirect
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

    def set_developer_by_id
        @developer = Developer.find_by(id: params[:developer_id])
    end

    def set_game_by_id
        @game = Game.find_by(id: params[:id])
    end    

    def set_instance_variable
        @developer = Developer.find_by(id: params[:developer_id])
        if @developer
            @game = @developer.games.find_by(id: params[:id])
        else
            @game = Game.find_by(id: params[:id])
        end
    end

    def current_user_can_CRUD?
        @game.user_has_permission_to_CRUD?(current_user)
    end

end