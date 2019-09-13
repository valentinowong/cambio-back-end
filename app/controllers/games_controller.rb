class GamesController < ApplicationController

    def index
        games = Game.all_sorted_oldest_to_newest
        render json: games, include: [:players, :game_players]
    end

    def show

    end

    def create
        game = Game.new(game_params)
        if game.save
            game.game_players.create(player_id: params[:game_players_attributes]["0"]["player_id"])
            game.create_deck
            ActionCable.server.broadcast('games_channel',{game: {id: game.id, name: game.name, status: game.status, phase: game.phase, players: game.players }})
            render json: game, include: [:players, :game_players, :piles, :cards]
        else
            render json: {errors: game.errors.full_messages}, status: 422
        end
    end

    private

    def game_params
        params.require(:game).permit(
            :name,
            :status,
            :phase,
            game_players_attributes: [:player_id]
        )
    end
end
