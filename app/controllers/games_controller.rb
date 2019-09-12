class GamesController < ApplicationController

    def index
        games = Game.all
        render json: games
    end

    def show

    end

    private

    def game_params
        params.require(:game).permit(:status,:phase)
    end
end
