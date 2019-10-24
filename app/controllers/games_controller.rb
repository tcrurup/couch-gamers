class GamesController < ApplicationController
    
    #User must be logged in before an actions in the game contoller are allowed to take place
    before_action :require_login
    before_action :set_developer_by_id, :except => [:edit, :index]
    before_action :set_game_by_id, :only => [:destroy, :edit, :update]



    def create
        @game = @developer.new_game(Game.new(game_params))
        
        if @game.user_has_permission_to_CRUD?(current_user) && @game.valid?          
            @game.save
            redirect_to developer_game_path(@game.developer, @game)
        else
            render :new
        end
    end

    def destroy  
        if@game.user_has_permission_to_CRUD?(current_user)
            @game.destroy       
            flash_and_redirect_to_show_page(@game.developer,"#{@game.title} has been removed")
        else
            render :show
        end            
    end

    def edit
        unless @game.user_has_permission_to_CRUD?(current_user)
            render :show
        end
    end
    
    def new
        @game = Game.new(developer_id: @developer.id)

        unless @game.user_has_permission_to_CRUD?(current_user)
            render "developers/show"
        end
    end

    def index
        if params[:developer_id]
            @games = Developer.find(params[:developer_id]).games
        else
            @games = Game.all
        end
    end

    def show
        @game = @developer.games.find_by(id: params[:id])
        if @game.nil? 
            message = "#{@developer.name} does not have a game with that id"
            flash_and_redirect_to_show_page(@developer, message)
        end                
    end

    def update
        set_game_by_id
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

    def developer_owns_game
        @developer.owns_game?(@game)
    end

    def game_params
        params.require(:game).permit(:title, :description, :release_year, :developer_id)
    end

    def set_game_by_id
        @game = Game.find_by(id: params[:id])
    end

    def set_developer_by_id
        @developer = Developer.find_by(id: params[:developer_id])
    end
end