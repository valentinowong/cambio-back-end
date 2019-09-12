class AddGamePlayerIdToPiles < ActiveRecord::Migration[5.2]
  def change
    add_column :piles, :game_player_id, :integer
  end
end
