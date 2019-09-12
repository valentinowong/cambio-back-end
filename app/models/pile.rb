class Pile < ApplicationRecord
    belongs_to :game
    has_many :cards
    belongs_to :game_player
end
