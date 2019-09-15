class GamesController < ApplicationController
    
    before_action :require_login

    def create
        @game = Game.new(game_params)
        if @game.valid?
            @game.save
            redirect_to game_path(@game)
        else
            render :new
        end
    end

    def destroy
        @game = Game.find_by(id: params[:id])
        @developer = Developer.find_by(id: params[:developer_id])

        errors = ["There was a problem with the following:"]
        errors << "#{@developer.name} does no own #{@game.title}" unless @developer.has_game?(@game)
        errors << "You are not a developer for #{@developer.name}" unless @developer.has_employee?(current_user)
        
        if errors.length > 1 
            flash_and_redirect_to_show_page(@game, errors.join(" "))       
        else
            redirect_to games_path
        end
    end

    def edit
        set_game_by_id
    end
    
    def new
        @game = Game.new(developer_id: params[:developer_id])
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
            @developer = Developer.find(params[:developer_id])
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
            redirect_to game_path(@game)
        else
            render :edit
        end
    end

    private

    def game_params
        params.require(:game).permit(:title, :description, :release_year, :developer_id)
    end

    def set_game_by_id
        @game = Game.find_by(id: params[:id])
    end
end