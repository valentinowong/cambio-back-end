class CreateGamePlayers < ActiveRecord::Migration[5.2]
  def change
    create_table :game_players do |t|
      t.integer :player_id
      t.integer :game_id
      t.boolean :status, :default => false
      t.boolean :current_turn, :default => false

      t.timestamps
    end
  end
end
