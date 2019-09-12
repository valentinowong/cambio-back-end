class CreateGames < ActiveRecord::Migration[5.2]
  def change
    create_table :games do |t|
      t.string :status
      t.integer :phase

      t.timestamps
    end
  end
end
