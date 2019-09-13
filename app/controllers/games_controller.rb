class GamesController < ApplicationController

    def create
        @game = Game.create(game_params)
        redirect_to game_path(@game)
    end
    
    def new
        @game = Game.new
    end

    def show
        @game = Game.find_by(id: params[:id])
    end

    private

    def game_params
        params.require(:game).permit(:title, :description, :release_year)
    end
end