class Game < ApplicationRecord
    has_many :game_players
    has_many :players, through: :game_players
    has_many :piles
    has_many :cards, through: :piles

    def create_deck
        suits = ['Hearts', 'Spades', 'Clubs', 'Diamonds']
        values = ['Ace', "2", "3", "4", "5", "6", "7", "8", "9", "10", 'Jack', 'Queen', 'King']
        deck = self.piles.create(name: "Deck")
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

    def self.all_sorted_newest_to_oldest
        Game.all.sort_by { |game| game.created_at }.reverse
    end

end
