class GamesController < ApplicationController

    def index
        games = Game.all_sorted_newest_to_oldest
        render json: games, include: [:players]
    end

    def show

    end

    private

    def game_params
        params.require(:game).permit(:status,:phase)
    end
end
