class Game < ApplicationRecord
    has_many :game_players
    has_many :players, through: :game_players
    has_many :piles
    has_many :cards, through: :piles

    def game_players_attributes=(game_player_attributes)
        game_player_attributes.values.each do |game_player_attribute|
          
          if game_player_attribute.values.all? { |attribute| !attribute.empty? }
            game_player = GamePlayer.create(game_player_attribute)
            self.game_players << game_player
          end
        end
    end

    def create_deck
        suits = ['Hearts', 'Spades', 'Clubs', 'Diamonds']
        values = ['Ace', "2", "3", "4", "5", "6", "7", "8", "9", "10", 'Jack', 'Queen', 'King']
        deck = self.piles.create(name: "Deck", game_player_id: self.game_players[0].id)
        suits.each do |suit|
            values.each do |value|
                code = "#{value[0]}#{suit[0]}"
                points = 0
                if ["2", "3", "4", "5", "6", "7", "8", "9"].include?(value)
                    points = value.to_i
                elsif ['10', 'Jack', 'Queen'].include?(value)
                    points = 10
                elsif value == 'Ace'
                    points = 1
                elsif ['KS','KC'].include?(code)
                    points = 10
                end
                deck.cards.create(image_url: "https://deckofcardsapi.com/static/img/#{code}.png", value: value, suit: suit, code: code, points: points)
            end
        end
        self.cards
    end

    def self.all_sorted_oldest_to_newest
        Game.all.sort_by { |game| game.created_at }
    end

    def start_game
        
        # For each game_player, draw 4 cards from the deck
        self.game_players.each do |game_player|
            hand = game_player.piles.create(name: "Hand", game_id: self.id)
            penalty = game_player.piles.create(name: "Penalty", game_id: self.id)
            deck = self.piles.find_by(name: "Deck")
            deck.cards.sample(4).each do |card|
                card.update(pile_id: hand.id)
            end
        end

        # Change a random game_player’s “current_turn” to ‘true’
        self.game_players.sample.update(current_turn: true)

        # Update the game status to in-progress
        self.status = "In Progress"

    end
    
    def piles_with_cards
        array = []
        self.piles.each do |pile|
            pile_hash = {}
            pile_hash[:id] = pile.id
            pile_hash[:name] = pile.name
            pile_hash[:game_id] = pile.game_id
            pile_hash[:game_player_id] = pile.game_player_id
            pile_hash[:cards] = pile.cards
            array << pile_hash
        end
        array
    end

end
