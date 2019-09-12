class PlayersController < ApplicationController

    def create
        player = Player.new(player_params)
        if player.save
            render json: player
        else
            render json: {errors: player.errors.full_messages}, status: 422
        end
    end

    private

    def player_params
        params.require(:player).permit(:name)
    end
end
