class CreatePiles < ActiveRecord::Migration[5.2]
  def change
    create_table :piles do |t|
      t.string :name
      t.integer :game_id
      t.integer :game_player_id

      t.timestamps
    end
  end
end
