class GamePlayersController < ApplicationController
    before_action :set_game_player, only: [:update]

    def update
        @game_player.update(game_player_params)
        game = Game.find(@game_player.game_id)
        if game.game_players.all? {|game_player| game_player.status}
            game.start_game
            GameDetailsChannel.broadcast_to(game,{
                begin_game: {
                    id: game.id, 
                    name: game.name, 
                    status: game.status, 
                    phase: game.phase, 
                    players: game.players, 
                    game_players: game.game_players, 
                    piles: game.piles_with_cards, 
                    cards: game.cards
                }
            })
        else
            GameDetailsChannel.broadcast_to(game,{game_player_update: {id: @game_player.id, player_id: @game_player.player_id, game_id: @game_player.game_id, game_name: @game_player.game.name, player_name: @game_player.player.name, status: @game_player.status}})
        end
        render json: @game_player
    end

    def create
        game_player = GamePlayer.new(game_player_params)
        if game_player.save
            ActionCable.server.broadcast('games_channel', {game_player: {id: game_player.id, player_id: game_player.player_id, game_id: game_player.game_id, game_name: game_player.game.name, player_name: game_player.player.name}})            
            game = Game.find(game_player.game_id)
            GameDetailsChannel.broadcast_to(game,{game_player: {id: game_player.id, player_id: game_player.player_id, game_id: game_player.game_id, game_name: game_player.game.name, player_name: game_player.player.name}})
            render json: game, include: [:players, :game_players, :piles, :cards]
        else
            render json: {errors: game_player.errors.full_messages}, status: 422
        end
    end

    private

    def set_game_player
        @game_player = GamePlayer.find(params[:id])
    end

    def game_player_params
        params.require(:game_player).permit(:game_id, :player_id, :status)
    end
end
