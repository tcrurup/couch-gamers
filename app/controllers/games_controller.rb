class GamesController < ApplicationController

    def create
        @game = Game.new(game_params)
        
        if @game.valid?
            @game.save
            redirect_to game_path(@game)
        else
            render :new
        end
    end

    def edit
        set_game_by_id
    end
    
    def new
        @game = Game.new
    end

    def index
        @games = Game.all
    end

    def show
        set_game_by_id
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
        params.require(:game).permit(:title, :description, :release_year)
    end

    def set_game_by_id
        @game = Game.find_by(id: params[:id])
    end
end