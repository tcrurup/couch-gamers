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
        Game.find_by(id: params[:id]).destroy
        redirect_to games_path
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