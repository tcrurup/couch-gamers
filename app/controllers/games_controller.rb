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
    
    def new
        @game = Game.new
    end

    def index
        @games = Game.all
    end

    def show
        @game = Game.find_by(id: params[:id])
    end

    private

    def game_params
        params.require(:game).permit(:title, :description, :release_year)
    end
end