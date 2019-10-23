class GamesController < ApplicationController
    
    #User must be logged in before an actions in the game contoller are allowed to take place
    before_action :require_login

    def create
        #Only developers owners and people employed by developers can create games
        set_developer_by_id

        if current_user_employed_at_developer        
            @game = @developer.create_game(Game.new(game_params))
            
            if @game.valid?                
                redirect_to developer_game_path(@game.developer, @game)
            else
                render :new
            end
        else
            message = "You are not a developer for #{@developer.name}" 
        end
    end

    def destroy
        set_game_by_id
        set_developer_by_id
        
        if@game.valid_destroy?(current_user)
            @game.destroy       
            flash_and_redirect_to_show_page(@game.developer,"#{@game.title} has been removed")
        else
            render :show
        end            
    end

    def edit
        set_game_by_id
    end
    
    def new
        set_developer_by_id
        message = nil;
        if @developer.nil?
            message = "No developer with that id"
        elsif !@developer.has_employee?(current_user)
            message = "You don't work for #{@developer.name}"
        end
        
        if(message)
            flash_and_redirect_to_index_page(@developer, message)
        else
            @game = Game.new(developer_id: @developer.id)
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
        if params[:developer_id]
            set_developer_by_id
            @game = @developer.games.find_by(id: params[:id])
            if @game.nil? 
                message = "#{@developer.name} does not have a game with that id"
                flash_and_redirect_to_show_page(@developer, message)
            end                
        else
            set_game_by_id
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