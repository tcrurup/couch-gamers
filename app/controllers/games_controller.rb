class GamesController < ApplicationController

    def create
        @game = Game.create(game_params)
    end
    
    def new
        @game = Game.new
    end

    private

    def game_params
        params.require(:game).permit(:title, :description, :release_year)
    end
end